//
//  SchoolViewModel.swift
//  NYCSchoolDataDemo
//
//  Created by RADHIKA SHARMA on 8/26/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class SchoolViewModel: NSObject {
    
    var school_name: String
    var city: String
    var phoneNum: String
    var satScore: SATScore
    
    init(name: String, city: String, phone: String){
        self.school_name = name
        self.city = city
        self.phoneNum = phone
        self.satScore = SATScore(math: 350, reading: 350, writing: 350)
        super.init()
    }

}
