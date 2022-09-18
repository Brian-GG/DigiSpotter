//
//  Bones.swift
//  BodyTracking2022
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import Foundation

enum Bones: CaseIterable{
    case leftShoulderToLeftArm
    case leftArmToLeftForarm
    case leftForearmToLeftHand
    
    case rightShoulderToRightArm
    case rightArmToRightForarm
    case rightForearmToRightHand
    
    case spine7ToLeftShoulder
    case spine7ToRightShoulder
    
    case neck1ToSpine7
    case spine7ToSpine6
    case spine6ToSpine5
    
    case hipsToLeftUpLeg
    case leftUpLegToLeftLeg
    case leftLegToLeftFoot
    
    case hipsToRightUpLeg
    case rightUpLegToRightLeg
    case rightLegToRightFoot
    
    var name: String{
        return "\(self.jointFromName)-\(jointToName)"
    }
    
    var jointFromName: String{
        switch self{
        case .leftShoulderToLeftArm:
            return "left_shoulder_1_joint"
        case .leftArmToLeftForarm:
            return "left_arm_joint"
        case .leftForearmToLeftHand:
            return "left_forearm_jint"
            
        case .rightShoulderToRightArm:
            return "right_shoulder_1_joint"
        case .rightArmToRightForarm:
            return "right_arm_joint"
        case .rightForearmToRightHand:
            return "right_forearm_joint"
            
        case .spine7ToLeftShoulder:
            return "spine_7_joint"
        case .spine7ToRightShoulder:
            return "spine_7_joint"
            
        case .neck1ToSpine7:
            return "neck_1_joint"
        case .spine7ToSpine6:
            return "spine_7_joint"
        case .spine6ToSpine5:
            return "spine_6_jint"
            
        case .hipsToLeftUpLeg:
            return "hips_joint"
        case .leftUpLegToLeftLeg:
            return "left_upLeg_joint"
        case .leftLegToLeftFoot:
            return "left_leg_joint"
            
        case .hipsToRightUpLeg:
            return "hips_joint"
        case .rightUpLegToRightLeg:
            return "right_upLeg_joint"
        case .rightLegToRightFoot:
            return "right_leg_joint"
        }
    }
    
    var jointToName: String{
        switch self{
            
        case .leftShoulderToLeftArm:
            return "left_arm_joint"
        case .leftArmToLeftForarm:
            return "left_forearm_joint"
        case .leftForearmToLeftHand:
            return "left_hand_joint"
            
        case .rightShoulderToRightArm:
            return "right_arm_joint"
        case .rightArmToRightForarm:
            return "right_forearm_joint"
        case .rightForearmToRightHand:
            return "right_hand_joint"
            
        case .spine7ToLeftShoulder:
            return "left_shoulder_1_joint"
        case .spine7ToRightShoulder:
            return "right_shoulder_1_joint"
            
        case .neck1ToSpine7:
            return "spin_7_joint"
        case .spine7ToSpine6:
            return "spine_6_joint"
        case .spine6ToSpine5:
            return "spine_5_joint"
            
        case .hipsToLeftUpLeg:
            return "left_upLeg_joint"
        case .leftUpLegToLeftLeg:
            return "left_leg_joint"
        case .leftLegToLeftFoot:
            return "leg_foot_joint"
            
        case .hipsToRightUpLeg:
            return "right_upLeg_joint"
        case .rightUpLegToRightLeg:
            return "right_leg_joint"
        case .rightLegToRightFoot:
            return "right_foot_joint"
        }
    }
}
