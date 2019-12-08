//
//  SpaceXService.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:Any]

enum WebRequestError: Error {
    case RocketWikiURLNotFound
}

class SpaceXService: WebServiceProtocol {
    
    func fetchLaunches(completionHandler: @escaping ([Launch], Error?) -> Void) {
        
        URLSession.shared.dataTask(with: URL.launches) { data, response, error in

            if let data = data {

                let launchDictionaries = try! JSONSerialization.jsonObject(with: data, options: []) as! [JSONDictionary]

                let launches = launchDictionaries.compactMap { (dict) -> Launch? in
                    let json = dict as JSONDictionary
                    
                    guard
                        let flightNumber = json["flight_number"] as? Int,
                        let missionName = json["mission_name"] as? String,
                        let launchSuccess = json["launch_success"] as? Bool,
                        let launchDateString = json["launch_date_utc"] as? String,
                        let rocketDict = json["rocket"] as? JSONDictionary else {
                            return nil
                    }
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    guard let launchDate = dateFormatter.date(from: launchDateString) else {
                        return nil
                    }
                    
                    guard
                        let rocketId = rocketDict["rocket_id"] as? String,
                        let rocketName = rocketDict["rocket_name"] as? String,
                        let rocketType = rocketDict["rocket_type"] as? String else {
                            return nil
                    }
                    let rocket = Rocket(id: rocketId, name: rocketName, type: rocketType)
                    
                    return Launch(flightNumber: flightNumber, missionName: missionName, launchDate: launchDate, launchSuccess: launchSuccess, rocket: rocket)
                }
                
                completionHandler(launches, nil)
                
            } else {
                completionHandler([], error)
            }
            
        }.resume()
        
    }
    
    func fetchRocketWikiURL(id: String, completionHandler: @escaping (URL?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: URL.rocket(id: id)) { data, response, error in

            if let data = data {

                let rocketDict = try! JSONSerialization.jsonObject(with: data, options: []) as! JSONDictionary
                
                if let rocketWikiURLString = rocketDict["wikipedia"] as? String {
                    completionHandler(URL(string: rocketWikiURLString), nil)
                } else {
                    completionHandler(nil, WebRequestError.RocketWikiURLNotFound)
                }
    
            } else {
                completionHandler(nil, error)
            }
            
        }.resume()
    }
    
}
