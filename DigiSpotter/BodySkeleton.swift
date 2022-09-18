//
//  BodySkeleton.swift
//  BodyTracking2022
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import Foundation
import RealityKit
import ARKit

class BodySkeleton: Entity{
    var joints: [String: Entity] = [:]
    var bones: [String: Entity] = [:]
    
    var repCounter: Int = 0
    var setCounter: Int = 0
    
    var currentPos: Float = 0
    var previousPos: Float = 0
    var highestPos: Float = 0
    var lowestPos: Float = 0
    
    var shimmy:Bool = true;
    
    required init(for bodyAnchor: ARBodyAnchor) {
        super.init()
        
        for jointName in ARSkeletonDefinition.defaultBody3D.jointNames{
            var jointRadius: Float = 0.05
            var jointColor: UIColor = .green
            
            switch jointName{
            case "neck_1_joint", "neck_2_joint", "neck_3_joint", "neck_4_joint", "head_joint", "left_shoulder_1_joint", "right_shoulder_1_joint":
                jointRadius *= 0.5
            case "jaw_joint", "chin_joint", "left_eye_joint", "left_eyeLowerLid_joint", "left_eyeUpperLid_joint", "left_eyeball_joint", "nose_joint", "right_eye_joint", "right_eyeLowerLid_joint", "right_eyeUpperLid_joint", "right_eyeball_joint":
                jointRadius *= 0.2
                jointColor = .yellow
            case _ where jointName.hasPrefix("spine_"):
                jointRadius *= 0.75
            case "left_hand_joint", "right_hand_joint":
                jointRadius *= 1
                jointColor = .green
            case _ where jointName.hasPrefix("left_hand") || jointName.hasPrefix("right_hand"):
                jointRadius *= 0.25
                jointColor = .yellow
            case _ where jointName.hasPrefix("left_toes") || jointName.hasPrefix("right_toes"):
                jointRadius *= 0.5
                jointColor = .yellow
            default:
                jointRadius *= 0.05
                jointColor = .green
            }
            
            let jointEntity = createJoint(radius: jointRadius, color: jointColor)
            joints[jointName] = jointEntity
            self.addChild(jointEntity)
        }
        
        for bone in Bones.allCases{
            guard let skeletonBone = createSkeletonBones(bone: bone, bodyAnchor: bodyAnchor)
            else {continue}
            
            let boneEntity = createBoneEntity(for: skeletonBone)
            bones[bone.name] = boneEntity
            self.addChild(boneEntity)
        }
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func update(with bodyAnchor: ARBodyAnchor){
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        
        for jointName in ARSkeletonDefinition.defaultBody3D.jointNames{
            if let jointEntity = joints[jointName],
               let jointEntityTranform = bodyAnchor.skeleton.modelTransform(for: ARSkeleton.JointName(rawValue: jointName)){
                let jointEntityOffsetFromRoot = simd_make_float3(jointEntityTranform.columns.3)
                
                jointEntity.position = jointEntityOffsetFromRoot + rootPosition
                jointEntity.orientation = Transform(matrix: jointEntityTranform).rotation
                // if jointName ==
                if jointName == "hips_joint"{
                    currentPos = jointEntity.position.y
                    
                    if repCounter == 0 {
                        if currentPos <= lowestPos{
                            lowestPos = currentPos
                        }
                        
                        if currentPos >= highestPos{
                            highestPos = currentPos
                        }
                    } else {
                        if (highestPos - currentPos) <= 0.2 && currentPos - lowestPos >= 0.45 && shimmy == true{
                            repCounter += 1
                            shimmy = false
                        } else {
                            if currentPos - lowestPos <= 0.2 {
                                shimmy = true
                            }
                        }
                    }
                                        
                    print(repCounter)
                }
            }
        }
        
        
        for bone in Bones.allCases {
            let boneName = bone.name
            
            guard let entity = bones[boneName],
                  let skeletonBone = createSkeletonBones(bone: bone, bodyAnchor: bodyAnchor)
            else {continue}
            
            entity.position = skeletonBone.centerPosition
            // Left upper leg bone ->
            if boneName == "hips_joint-left_upLeg_joint"{
                let resultant = simd_make_float3(simd_cross(skeletonBone.toJoint.position, skeletonBone.fromJoint.position))
                
                let angle:Float = (abs(resultant.y)) / sqrt(pow(resultant.x,2) + pow(resultant.y,2) + pow(resultant.z,2))
                let angleDegShived:Float = (angle * 180 / .pi) - 45
//                print("The angle of the bone is:\(angleDegShived)");
            }
            
            // Right upper leg bone
            if boneName == "hips_joint-right_upLeg_joint"{
                let resultant = simd_make_float3(simd_cross(skeletonBone.toJoint.position, skeletonBone.fromJoint.position))
                
                let angle:Float = (abs(resultant.y)) / sqrt(pow(resultant.x,2) + pow(resultant.y,2) + pow(resultant.z,2))
                let angleDegShived:Float = (angle * 180 / .pi) - 45
//                print("The angle of the bone is:\(angleDegShived)");
            }

            // Spine bone(s)
            switch boneName {
                case "spine_7_joint-spine_6_joint":
                    let resultant = simd_make_float3(simd_cross(skeletonBone.toJoint.position, skeletonBone.fromJoint.position))
                    let angle:Float = (abs(resultant.y)) / sqrt(pow(resultant.x,2) + pow(resultant.y,2) + pow(resultant.z,2))
                    let angleDegShived:Float = (angle * 180 / .pi)
                if abs(angleDegShived) > 3.5 {
//                    print("Your back is too bent")
                }
                // print("The angle for the spine 7-6 is:\(angleDegShived)");


                case "spine_6_joint-spine_5_joint":
                    let resultant = simd_make_float3(simd_cross(skeletonBone.toJoint.position, skeletonBone.fromJoint.position))
                    let angle:Float = (abs(resultant.y)) / sqrt(pow(resultant.x,2) + pow(resultant.y,2) + pow(resultant.z,2))
                    let angleDegShived:Float = (angle * 180 / .pi)
                if abs(angleDegShived) > 3.5 {
//                    print("Your back is too bent")
                }
                // print("The angle for the spine 6-5 is:\(angleDegShived)");

                
                case "neck_1_joint-spine_7_joint":
                    let resultant = simd_make_float3(simd_cross(skeletonBone.toJoint.position, skeletonBone.fromJoint.position))
                    let angle:Float = (abs(resultant.y)) / sqrt(pow(resultant.x,2) + pow(resultant.y,2) + pow(resultant.z,2))
                    let angleDegShived:Float = (angle * 180 / .pi)
                if abs(angleDegShived) > 3.5 {
//                    print("Your upper back is too bent")
                }
                // print("The angle for the necky spine 1-7 is:\(angleDegShived)");
                
            default:
                break;

            }
            
            entity.look(at: skeletonBone.toJoint.position, from: skeletonBone.centerPosition, relativeTo: nil)
            
        }
        
        if highestPos - currentPos <= 0.2 && currentPos - lowestPos >= 0.45 && shimmy == true {
            repCounter += 1
            shimmy = false
        } else {
            if currentPos - lowestPos <= 0.2 {
                shimmy = true
            }
        }
        
    
        print("highest=\(highestPos)")
        print("currentPos=\(currentPos)")
        print("lowesr=\(lowestPos)")
        print("reps=\(repCounter)")
    }
    
    private func createJoint(radius: Float, color: UIColor = .white) -> Entity{
        let mesh = MeshResource.generateSphere(radius: radius)
        let material = SimpleMaterial(color: color, roughness: 0.8, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        
        return entity
    }
    
    private func createSkeletonBones(bone: Bones, bodyAnchor: ARBodyAnchor) ->SkeletonBone?{
        guard let fromJointEntityTransform = bodyAnchor.skeleton.modelTransform(for: ARSkeleton.JointName(rawValue: bone.jointFromName)),
              let toJointEntityTransform = bodyAnchor.skeleton.modelTransform(for: ARSkeleton.JointName(rawValue: bone.jointToName))
        else {return nil}
        
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        
        let jointFromEntityOffsetFromRoot = simd_make_float3(fromJointEntityTransform.columns.3)
        let jointFromEntityPosition = jointFromEntityOffsetFromRoot + rootPosition
        
        let jointToEntityOffsetFromRoot = simd_make_float3(toJointEntityTransform.columns.3)
        let jointToEntityPosition = jointToEntityOffsetFromRoot + rootPosition
        
        let fromJoint = SkeletonJoint(name: bone.jointFromName, position: jointFromEntityPosition)
        let toJoint = SkeletonJoint(name: bone.jointToName, position: jointToEntityPosition)
        
        return SkeletonBone(fromJoint: fromJoint, toJoint: toJoint)
    }
    
    private func createBoneEntity(for skeletonBone: SkeletonBone, diameter: Float = 0.04, color: UIColor = .white) -> Entity{
        let mesh = MeshResource.generateBox(size: [diameter, diameter, skeletonBone.length], cornerRadius: diameter / 2)
        let material = SimpleMaterial(color: color, roughness: 0.8,isMetallic: true)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        
        return entity
    }
    
}
