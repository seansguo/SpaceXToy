//
//  LaunchListViewController.swift
//  TABAssignment
//
//  Created by Sean Guo on 7/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import UIKit

class LaunchListViewController: UITableViewController {
    
    private let remoteDataStore = RemoteDataStore()
    private var localDataStore = LocalDataStore()
    
    private var successFilter = true
    private var nameSortOrder = SortOrder.Ascending
    private var dateSortOrder = SortOrder.Ascending
    
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
        
    }
    
    func setupUI() {
        self.title = self.viewModel.title
    }
    
    func setupViewModel(launches: [Launch]) {
        let launches = launches.map { launch in
            return LaunchViewModel(launch :launch)
        }
        self.viewModel = LaunchListViewModel(launches: launches)
    }
    
    func fetchLaunches() {
        self.remoteDataStore.fetchLaunches { (launches, error) in
            self.localDataStore.setLaunches(launches: launches)
            self.setupViewModel(launches: launches)
        }
    }
    
    func filterBySuccess(success: Bool) {
        self.localDataStore.fetchLaunchesBySuccess(success: success) { (launches, error) in
            self.setupViewModel(launches: launches)
        }
    }
    
    func sort(sortType: SortType, sortOrder: SortOrder) {
        self.localDataStore.fetchLaunchesSorted(sortType: sortType, sortOrder: sortOrder) { (launches, error) in
            self.setupViewModel(launches: launches)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.launches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "launchCell", for: indexPath)
        let launchViewModel = self.viewModel.launches[indexPath.row]
        
        cell.textLabel?.text = launchViewModel.missionName
        cell.detailTextLabel?.text = launchViewModel.date + " (" + launchViewModel.success + ")"
        return cell
    }
    
    @IBAction func filterBySuccessClicked(_ sender: UIBarButtonItem) {
        self.filterBySuccess(success: self.successFilter)
        self.successFilter = !self.successFilter
    }
    
    @IBAction func sortByNameClicked(_ sender: UIBarButtonItem) {
        self.sort(sortType: .Name, sortOrder: self.nameSortOrder)
        if self.nameSortOrder == .Ascending {
            self.nameSortOrder = .Descending
        } else {
            self.nameSortOrder = .Ascending
        }
    }
    
    @IBAction func sortByDateClicked(_ sender: UIBarButtonItem) {
        self.sort(sortType: .Date, sortOrder: self.dateSortOrder)
        if self.dateSortOrder == .Ascending {
            self.dateSortOrder = .Descending
        } else {
            self.dateSortOrder = .Ascending
        }
    }

}

