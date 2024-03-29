//
//  RemoteDataStore.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

class RemoteDataStore: DataStoreProtocol {
    
    static let shared = RemoteDataStore()
    
    private var webService: WebServiceProtocol
    
    private init() {
        self.webService = SpaceXService()
    }
    
    func fetchLaunches(completionHandler: @escaping ([Launch], Error?) -> Void) {
        self.webService.fetchLaunches { (launches, error) in
            completionHandler(launches, error)
        }
    }
    
    func fetchRocketWikiURL(id: String, completionHandler: @escaping (URL?, Error?) -> Void) {
        self.webService.fetchRocketWikiURL(id: id) { (rocketWikiURL, error) in
            completionHandler(rocketWikiURL, error)
        }
    }
}
