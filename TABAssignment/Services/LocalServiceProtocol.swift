//
//  LocalServiceProtocol.swift
//  TABAssignment
//
//  Created by Sean Guo on 8/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

protocol LocalServiceProtocol {
    
    //MARK: - List of Launches
    
    func fetchLaunches(completionHandler: @escaping ([Launch], Error?) -> Void)
    
    func fetchLaunchesBySuccess(success: Bool, completionHandler: @escaping ([Launch], Error?) -> Void)
    
    func fetchLaunchesSorted(groupBy: GroupBy, completionHandler: @escaping ([Launch], Error?) -> Void)
    
    //MARK: - One Launch
    
    func fetchOneLaunch(flightNumber: Int, completionHandler: @escaping (Launch?, Error?) -> Void)
    
    //MARK: - Rocket Wiki URL
    
    func fetchRocketWikiURL(id: String, completionHandler: @escaping (URL?, Error?) -> Void)
    
    //MARK: - Set Launches
    
    func setLaunches(launches: [Launch])
    
    //MARK: - Set Rocket Wiki URL
    
    func setRocketWikiURL(flightNumber: Int, url: URL) -> Launch?
}
