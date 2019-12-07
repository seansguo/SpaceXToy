//
//  LaunchListViewController.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import UIKit

class LaunchListViewController: UITableViewController {
    
    private let dataStore = RemoteDataStore()
    
    private var viewModel: LaunchListViewModel = LaunchListViewModel() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.fetchLaunches()
        
//
//        self.dataStore.fetchRocketWikiURL(id: "falcon1") { (rocketWikiURL, error) in
//            print(rocketWikiURL)
//        }
    }
    
    func setupUI() {
        self.title = self.viewModel.title
    }
    
    func fetchLaunches() {
        self.dataStore.fetchLaunches { (launches, error) in
            
            let launches = launches.map { launch in
                return LaunchViewModel(launch :launch)
            }
            self.viewModel = LaunchListViewModel(launches: launches)
        }
    }

}

