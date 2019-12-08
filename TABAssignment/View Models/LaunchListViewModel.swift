//
//  LaunchListViewModel.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

struct LaunchViewModel {
    var flightNUmber: Int
    var missionName: String
    var date: String
    var success: String
}

extension LaunchViewModel {
    init(launch: Launch) {
        self.flightNUmber = launch.flightNumber
        self.missionName = launch.missionName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date = dateFormatter.string(from: launch.launchDate)
        
        self.success = launch.launchSuccess ? "Success" : "Fail"
    }
}

struct LaunchListViewModel {
    private var launches: [LaunchViewModel] = [LaunchViewModel]()
    var title: String? = "Launches"
    var sectionTitles: [String] = []
    var launchesInSections:[[LaunchViewModel]] = []
}

// MARK: - Initialization
extension LaunchListViewModel {
    init(launches: [LaunchViewModel]) {
        self.launches = launches
        self.sectionTitles = [""]
        self.launchesInSections = [self.launches]
    }
}

extension LaunchListViewModel {
    init(launches: [LaunchViewModel], groupBy: GroupBy) {
        self.launches = launches
        
        var launchesGroupedDict: [String:[LaunchViewModel]] = [:]
        
        if groupBy == .Name {
            launchesGroupedDict = Dictionary(grouping: self.launches) { String($0.missionName.first!) } as [String:[LaunchViewModel]]
        } else {
            launchesGroupedDict = Dictionary(grouping: self.launches) { String($0.date.prefix(4)) } as [String:[LaunchViewModel]]
        }
        
        let sortedKeys = launchesGroupedDict.keys.sorted()
        self.sectionTitles = sortedKeys.map({String($0)})
       
        self.launchesInSections = []
       
        for key in sortedKeys {
            self.launchesInSections.append(launchesGroupedDict[key]!)
        }
        
    }
}

