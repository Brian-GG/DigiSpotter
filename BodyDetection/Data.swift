//
//  Data.swift
//  BodyDetection
//
//  Created by Nikhil Yerasi on 12/6/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

struct Person {
    let name: String!
    let affiliation: String!
    let profileImage: UIImage!
}

class Data {
    // update var as needed!
    public var people = [
        Person(name: "Brian Grigore", affiliation: "Undergraduate, Queens University", profileImage: UIImage(named: "bgrigore")),
        Person(name: "Keane Moraes", affiliation: "Undergraduate, University of Waterloo", profileImage: UIImage(named: "k3moraes")),
        Person(name: "Nicholas Pardede", affiliation: "Graduate, Conestoga College", profileImage: UIImage(named: "npardede")),
        Person(name: "Kareem Ghadban", affiliation: "Undergradaute, Western University", profileImage: UIImage(named: "kghadban"))
    ]
}
