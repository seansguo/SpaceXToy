//
//  InMemoryService.swift
//  TABAssignment
//
//  Created by Sean Guo on 8/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

enum GroupBy {
    case Name
    case Date
}

class InMemoryService: LocalServiceProtocol {
    private var launches: [Launch] = []
    
    func fetchLaunches(completionHandler: @escaping ([Launch], Error?) -> Void) {
        completionHandler(self.launches, nil)
    }
    
    func fetchLaunchesBySuccess(success: Bool, completionHandler: @escaping ([Launch], Error?) -> Void) {
        let filteredLaunches = self.launches.filter { (launch) -> Bool in
            return launch.launchSuccess == success
        }
        completionHandler(filteredLaunches, nil)
    }
    
    func fetchLaunchesSorted(groupBy: GroupBy, completionHandler: @escaping ([Launch], Error?) -> Void) {
        let sortedLaunches = self.launches.sorted { (a, b) -> Bool in
            
            if groupBy == .Name {
                return a.missionName.lowercased() < b.missionName.lowercased()
            } else {
                return a.launchDate < b.launchDate
            }
            
        }
        completionHandler(sortedLaunches, nil)
    }
    
    func fetchOneLaunch(flightNumber: Int, completionHandler: @escaping (Launch?, Error?) -> Void) {
        let launch = self.launches.filter { (launch) -> Bool in
            return launch.flightNumber == flightNumber
        }.first
        completionHandler(launch, nil)
    }
    
    func fetchRocketWikiURL(id: String, completionHandler: @escaping (URL?, Error?) -> Void) {
        
        let launch = self.launches.filter { (launch) -> Bool in
            return launch.rocket.id == id
        }.first
        
        if let launch = launch {
            completionHandler(launch.rocket.wikiURL, nil)
        } else {
            completionHandler(nil, nil)
        }
    }
    
    func setLaunches(launches: [Launch]) {
        self.launches = launches
    }
    
    func setRocketWikiURL(flightNumber: Int, url: URL) -> Launch? {
        for index in 0..<self.launches.count {
            if self.launches[index].flightNumber == flightNumber {
                self.launches[index].rocket.wikiURL = url
                return self.launches[index]
            }
        }
        return nil
    }
}
