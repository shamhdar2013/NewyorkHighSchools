//
//  SATScore.swift
//  NYCSchoolDataDemo
//
//  Created by RADHIKA SHARMA on 8/26/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class SATScore: NSObject {
    
    var math: Int
    var reading: Int
    var writing: Int
    
    init(math: Int, reading: Int, writing: Int) {
        self.math = math
        self.reading = reading
        self.writing = writing
        super.init()
    }

}
