//
//  Exercise.swift
//  DigiSpotter
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import Foundation

class Exercise{
    var startTime: String
    var endTime: String
    var numReps: Int
    var numSets: Int
    var restTime: Int
    
    init(startTime: String, endTime: String, numReps: Int, numSets: Int, restTime: Int){
        self.startTime = startTime
        self.endTime = endTime
        self.numReps = numReps
        self.numSets = numSets
        self.restTime = restTime
    }
}
