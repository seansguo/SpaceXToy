//
//  LocalDataStore.swift
//  TABAssignment
//
//  Created by Sean Guo on 8/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

class LocalDataStore: DataStoreProtocol, SettableDataStoreProtocol, SortableDataStoreProtocol {
    
    static let shared = LocalDataStore()
    
    private var localService: LocalServiceProtocol
    
    private init() {
        self.localService = InMemoryService()
    }
    
    func fetchLaunches(completionHandler: @escaping ([Launch], Error?) -> Void) {
        self.localService.fetchLaunches { (launches, error) in
            completionHandler(launches, error)
        }
    }
    
    func fetchRocketWikiURL(id: String, completionHandler: @escaping (URL?, Error?) -> Void) {
        self.localService.fetchRocketWikiURL(id: id) { (rocketWikiURL, error) in
            completionHandler(rocketWikiURL, error)
        }
    }
    
    func setLaunches(launches: [Launch]) {
        self.localService.setLaunches(launches: launches)
    }
    
    func setRocketWikiURL(flightNumber: Int, url: URL) -> Launch? {
        return self.localService.setRocketWikiURL(flightNumber: flightNumber, url: url)
    }
    
    func fetchLaunchesBySuccess(success: Bool, completionHandler: @escaping ([Launch], Error?) -> Void) {
        self.localService.fetchLaunchesBySuccess(success: success) { (launches, error) in
            completionHandler(launches, error)
        }
    }
    
    func fetchLaunchesSorted(groupBy: GroupBy, completionHandler: @escaping ([Launch], Error?) -> Void) {
        self.localService.fetchLaunchesSorted(groupBy: groupBy) { (launches, error) in
            completionHandler(launches, error)
        }
    }
    
    func fetchOneLaunch(flightNumber: Int, completionHandler: @escaping (Launch?, Error?) -> Void) {
        self.localService.fetchOneLaunch(flightNumber: flightNumber) { (launch, error) in
            completionHandler(launch, error)
        }
    }
}
