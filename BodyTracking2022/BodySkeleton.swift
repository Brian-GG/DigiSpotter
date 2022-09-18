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
            }
        }
        for bone in Bones.allCases{
            let boneName = bone.name
            
            guard let entity = bones[boneName],
                  let skeletonBone = createSkeletonBones(bone: bone, bodyAnchor: bodyAnchor)
            else {continue}
            
            entity.position = skeletonBone.centerPosition
            // Left upper leg bone ->
            if boneName == "hips_joint-left_upLeg_joint"{
                let resultant = simd_make_float3(simd_cross(skeletonBone.toJoint.position, skeletonBone.fromJoint.position))
                
                let angle:Float = (abs(resultant.y)) / sqrt(pow(resultant.x,2) + pow(resultant.y,2) + pow(resultant.z,2))
                var angleDegShived:Float = (angle * 180 / .pi) - 45
//                print("The angle of the bone is:\(angleDegShived)");
            }
            
            // Right upper leg bone
            if boneName == "hips_joint-right_upLeg_joint"{
                let resultant = simd_make_float3(simd_cross(skeletonBone.toJoint.position, skeletonBone.fromJoint.position))
                
                let angle:Float = (abs(resultant.y)) / sqrt(pow(resultant.x,2) + pow(resultant.y,2) + pow(resultant.z,2))
                var angleDegShived:Float = (angle * 180 / .pi) - 45
//                print("The angle of the bone is:\(angleDegShived)");
            }
            entity.look(at: skeletonBone.toJoint.position, from: skeletonBone.centerPosition, relativeTo: nil)
            
        }
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
