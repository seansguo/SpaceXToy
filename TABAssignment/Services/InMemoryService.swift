//
//  InMemoryService.swift
//  TABAssignment
//
//  Created by Sean Guo on 8/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

enum SortOrder {
    case Ascending
    case Descending
}

enum SortType {
    case Name
    case Date
}

class InMemoryService: LocalServiceProtocol {
    private var launches: [Launch] = []
    private var rocketWikiURL: URL?
    
    func fetchLaunches(completionHandler: @escaping ([Launch], Error?) -> Void) {
        completionHandler(self.launches, nil)
    }
    
    func fetchLaunchesBySuccess(success: Bool, completionHandler: @escaping ([Launch], Error?) -> Void) {
        let filteredLaunches = self.launches.filter { (launch) -> Bool in
            return launch.launchSuccess == success
        }
        completionHandler(filteredLaunches, nil)
    }
    
    func fetchLaunchesSorted(sortType:SortType, sortOrder: SortOrder, completionHandler: @escaping ([Launch], Error?) -> Void) {
        let sortedLaunches = self.launches.sorted { (a, b) -> Bool in
            
            if sortType == .Name {
                if sortOrder == .Ascending {
                    return a.missionName.lowercased() < b.missionName.lowercased()
                } else {
                    return a.missionName.lowercased() > b.missionName.lowercased()
                }
            } else {
                if sortOrder == .Ascending {
                    return a.launchDate < b.launchDate
                } else {
                    return a.launchDate > b.launchDate
                }
            }
            
        }
        completionHandler(sortedLaunches, nil)
    }
    
    func fetchRocketWikiURL(id: String, completionHandler: @escaping (URL?, Error?) -> Void) {
        completionHandler(self.rocketWikiURL, nil)
    }
    
    func setLaunches(launches: [Launch]) {
        self.launches = launches
    }
    
    func setRocketWikiURL(url: URL) {
        self.rocketWikiURL = url
    }
}
