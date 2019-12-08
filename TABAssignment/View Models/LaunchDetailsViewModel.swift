//
//  LaunchDetailsViewModel.swift
//  TABAssignment
//
//  Created by Sean Guo on 8/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

struct RocketViewModel {
    var id: String
    var name: String
    var type: String
}

struct LaunchDetailViewModel {
    private var flightNUmber: Int = 0
    private var missionName: String = ""
    private var date: String = ""
    private var success: String = ""
    
    private var rocket: RocketViewModel = RocketViewModel(id: "", name: "", type: "")
    
    var title: String? = "Details"
    var sectionTitles: [String] = []
    var infoInSections: [[String]] = []
    var rocketWikiURL: URL?
}

extension LaunchDetailViewModel {
    init(launch: Launch) {
        self.flightNUmber = launch.flightNumber
        self.missionName = launch.missionName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date = dateFormatter.string(from: launch.launchDate)
        
        self.success = launch.launchSuccess ? "Success" : "Fail"
        
        self.rocket = RocketViewModel(id: launch.rocket.id, name: launch.rocket.name, type: launch.rocket.type)
        
        self.sectionTitles = ["Launch Details", "Rocket Details"]
        
        let launchDetails = [
            "Flight Number: \(self.flightNUmber)",
            "Mission Name: " + self.missionName,
            "Launch Date: " + self.date,
            "Launch Success: " + self.success
        ]
        
        let rocketDetails = [
            "Rocket Id: " + self.rocket.id,
            "Rocket Name: " + self.rocket.name,
            "Rocket Type: " + self.rocket.type
        ]
        
        self.infoInSections = [launchDetails, rocketDetails]
        
        self.rocketWikiURL = launch.rocket.wikiURL
    }
}
