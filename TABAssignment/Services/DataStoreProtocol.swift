//
//  DataStoreProtocol.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

protocol DataStoreProtocol {
    
    func fetchLaunches(completionHandler: @escaping ([Launch], Error?) -> Void)
    
    func fetchRocketWikiURL(id: String, completionHandler: @escaping (URL?, Error?) -> Void)
}

protocol SortableDataStoreProtocol {
    
    func fetchLaunchesBySuccess(success: Bool, completionHandler: @escaping ([Launch], Error?) -> Void)
    
    func fetchRocketWikiURL(id: String, completionHandler: @escaping (URL?, Error?) -> Void)
}

protocol SettableDataStoreProtocol {
    
    func setLaunches(launches: [Launch])
    
    func setRocketWikiURL(flightNumber: Int, url: URL) -> Launch?
}
