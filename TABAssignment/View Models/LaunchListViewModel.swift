//
//  LaunchListViewModel.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

struct LaunchViewModel {
    var missionName: String
    var date: String
    var success: String
}

extension LaunchViewModel {
    init(launch: Launch) {
        self.missionName = "Mission Name: " + launch.missionName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date = "Launch Date: " + dateFormatter.string(from: launch.launchDate)
        
        self.success = launch.launchSuccess ? "Success" : "Fail"
    }
}

struct LaunchListViewModel {
    var title: String? = "Launches"
    var launches: [LaunchViewModel] = [LaunchViewModel]()
}

// MARK: - Initialization
extension LaunchListViewModel {
    init(launches: [LaunchViewModel]) {
        self.launches = launches
    }
}

