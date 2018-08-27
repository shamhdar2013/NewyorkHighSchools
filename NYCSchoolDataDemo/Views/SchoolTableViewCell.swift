//
//  SchoolTableViewCell.swift
//  NYCSchoolDataDemo
//
//  Created by RADHIKA SHARMA on 8/25/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var phone: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.school.numberOfLines = 2
        self.city.text = NSLocalizedString("City_Label", comment: " ")
        self.phone.text = NSLocalizedString("Phone_Label", comment: " ")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(school: SchoolViewModel, row:Int) {
        self.school.text = school.school_name
        self.cityName.text =  school.city
        self.phoneNumber.text = school.phoneNum
    }
    
}
