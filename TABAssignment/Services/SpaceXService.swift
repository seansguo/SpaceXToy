//
//  SpaceXService.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

import Foundation

class SpaceXService: WebServiceProtocol {
    
    func fetchLaunches(completionHandler: @escaping ([Launch], Error?) -> Void) {
        
        print("called spaceX service")
        
        completionHandler([], nil)
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            print("called spaceX service")
//            completionHandler([], nil)
//        }
    }
    
}
