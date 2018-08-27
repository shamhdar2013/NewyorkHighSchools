//
//  SchoolSATScoreModel.swift
//  NYCSchoolDataDemo
//
//  Created by RADHIKA SHARMA on 8/26/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class SchoolSATScoreModel: NSObject {
    var school_name: String
    var satScore: SATScore
    
    init(name: String, math: Int, reading: Int, writing: Int) {
        self.school_name = name
        self.satScore = SATScore(math: math, reading: reading, writing: writing)
        super.init()
    }
    

}
