//
//  DataStoreProtocol.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import Foundation

protocol DataStoreProtocol {
    
    //MARK: - Business Logic
    
    func fetchLaunches(completionHandler: @escaping ([Launch], Error?) -> Void)
}
