//
//  URL+Extensions.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

extension URL {
    static var base: String {
        return "https://api.spacexdata.com/v3"
    }
    
    static var launches: URL {
        return URL(string: base + "/launches")!
    }
    
    static var rockets: URL {
        return URL(string: base + "/rockets")!
    }
}
