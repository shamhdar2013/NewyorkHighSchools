//
//  ViewController.swift
//  NYCSchoolDataDemo
//
//  Created by RADHIKA SHARMA on 8/25/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var schools = [String : SchoolViewModel]()
    var satScores = [String: SchoolSATScoreModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "SchoolTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "SchoolCell")
        self.tableView.separatorColor = UIColor.blue
        
        self.navigationItem.title = NSLocalizedString("Main_Title", comment: "Main View Title")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SchoolDataFetcher.shared().fetchSchoolsList() { (schoolDict, error) in
            
            if let sdict = schoolDict {
                SchoolDataFetcher.shared().fetchSATScores(){ (satDict, error) in
                    if let satList = satDict {
                       DispatchQueue.main.async {
                          self.satScores = satList
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.schools = sdict
                    self.tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SchoolCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SchoolTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BookTableViewCell.")
        }
        let row = indexPath.row
        let valArray = Array(self.schools.values)
        cell.configure(school: valArray[row], row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.values.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowIdx = indexPath.row
        
        if rowIdx < schools.count {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "SchoolDetailView") as! SchoolDetailViewController
            let valArray = Array(self.schools.values)
            let sname = valArray[rowIdx].school_name
            
            if let satScore = satScores[sname.uppercased()] {
                controller.satScore = satScore
            }
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

