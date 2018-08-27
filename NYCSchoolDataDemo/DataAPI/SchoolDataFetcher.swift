//
//  SchoolDataFetcher.swift
//  NYCSchoolDataDemo
//
//  Created by RADHIKA SHARMA on 8/25/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class SchoolDataFetcher: NSObject {
    let appToken =  "jwJBSRiYWVFyFAlFqZ7cjZd8M"
    let secretToken = "dtivvEfHowT08mOyjhfpdR4xDZJg8DXECxhy"
    let educationUrl = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    let SATUrl = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
    
    static let sharedInstance: SchoolDataFetcher = {
        let dataFetcher = SchoolDataFetcher()
        return dataFetcher
    }()
    override private init() {
    }
    
    class func shared() -> SchoolDataFetcher {
        return sharedInstance
    }

    func fetchSchoolsList(completion:@escaping([String:SchoolViewModel]?, Error?)->Void) {
        if let listUrl = URL(string:educationUrl ) {
            let request = NSMutableURLRequest(url: listUrl)
            request.addValue("application/json", forHTTPHeaderField:"Accept")
            request.addValue(appToken, forHTTPHeaderField:"X-App-Token")
            
            let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { data, response, reqError in
                if let mimeType = response?.mimeType, mimeType == "application/json" {
                    if let data = data {
                        do{
                            let jsonData = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers)
                            
                            if let array = jsonData as? [[String: Any]] {
                                let result = self.parseSchoolList(list: array)
                                completion(result, nil)
                            }
                        } catch {
                            print(error)
                            completion(nil, error)
                        }
                    } else {
                        if let error = reqError {
                            print(error)
                            completion(nil, error)
                        }
                    }
                }//mimeType
            }
            dataTask.resume()
        }
    }
    func fetchSATScores(completion:@escaping([String: SchoolSATScoreModel]?, Error?)->Void) {
        
        if let listUrl = URL(string: SATUrl ) {
            
            let request = NSMutableURLRequest(url: listUrl)
            request.addValue("application/json", forHTTPHeaderField:"Accept")
            request.addValue(appToken, forHTTPHeaderField:"X-App-Token")
            
            let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { data, response, reqError in
                
                if let data = data {
                    do{
                        let jsonData = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers)
                        
                        if let array = jsonData as? [[String: Any]] {
                            let result = self.parseSATScoreList(list: array)
                            completion(result, nil)
                        }
                    } catch {
                        completion(nil, error)
                    }
                    
                } else {
                    completion(nil, reqError)
                }
            }
            dataTask.resume()
        }
    }
    
    private func parseSchoolList(list: [[String: Any]])->[String: SchoolViewModel] {
        var result = [String: SchoolViewModel]()
        
        for item in list {
            var sname = " "
            var cname = " "
            var phone = "555-555-5555"
            if let name = item["school_name"] as? String {
                sname = name
            }
            
            if let city = item["city"] as? String {
                cname = city
            }
            
            if let phn = item["phone_number"] as? String {
                phone = phn
            }
            
            let  svm = SchoolViewModel(name: sname, city: cname, phone: phone)
            
            result[sname] = svm
        }
        
        return result
    }
    
    private func parseSATScoreList(list : [[String: Any]])->[String: SchoolSATScoreModel] {
         var result = [String: SchoolSATScoreModel]()
        for item in list {
            
            var sname = " "
            var smath = 350
            var sreading = 355
            var swriting = 400
            
            if let name = item["school_name"] as? String {
                sname = name
            }
            if let mathScore = item["sat_math_avg_score"] as? String, let intMath = Int(mathScore)  {
                smath = intMath
            }
            
            if let readScore = item["sat_critical_reading_avg_score"] as? String, let intRead = Int(readScore) {
                sreading = intRead
            }
            
            if let writeScore = item["sat_writing_avg_score"] as? String, let intWrite = Int(writeScore) {
                swriting = intWrite
            }
            
            let ssvm = SchoolSATScoreModel(name: sname, math: smath, reading: sreading, writing: swriting)
            
            result[sname] = ssvm
        }
        return result
    }

}
