//
//  SchoolDetailViewController.swift
//  NYCSchoolDataDemo
//
//  Created by RADHIKA SHARMA on 8/25/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var mathScore: UILabel!
    @IBOutlet weak var readLabel: UILabel!
    @IBOutlet weak var readScore: UILabel!
    @IBOutlet weak var writeLabel: UILabel!
    @IBOutlet weak var writeScore: UILabel!
    
    var satScore: SchoolSATScoreModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        school.numberOfLines = 2
        mathLabel.text = NSLocalizedString("Math_Label", comment: " ")
        readLabel.text = NSLocalizedString("Read_Label", comment: " ")
        writeLabel.text = NSLocalizedString("Write_Label", comment: " ")
        
        self.navigationItem.title = NSLocalizedString("Detail_Label", comment: " ")
        
        
        if let score = satScore {
            school.text = score.school_name
            mathScore.text = String(score.satScore.math)
            readScore.text = String(score.satScore.reading)
            writeScore.text = String(score.satScore.writing)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
