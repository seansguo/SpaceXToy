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
    private var currentGroupBy = GroupBy.Name // sort by name by default
    
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
    
    func setupViewModel(launches: [Launch], groupBy: GroupBy) {
        let launches = launches.map { launch in
            return LaunchViewModel(launch :launch)
        }
        self.viewModel = LaunchListViewModel(launches: launches, groupBy: groupBy)
    }
    
    // MARK: - Data and Sorting
    
    func fetchLaunches() {
        self.remoteDataStore.fetchLaunches { (launches, error) in
            
            // store data in local DB
            self.localDataStore.setLaunches(launches: launches)
        
            self.sort(groupBy: self.currentGroupBy)
        }
    }
    
    func filterBySuccess(success: Bool) {
        self.localDataStore.fetchLaunchesBySuccess(success: success) { (launches, error) in
            self.setupViewModel(launches: launches, groupBy: self.currentGroupBy)
        }
    }
    
    func sort(groupBy: GroupBy) {
        self.localDataStore.fetchLaunchesSorted(groupBy: groupBy) { (launches, error) in
            self.setupViewModel(launches: launches, groupBy: groupBy)
            self.currentGroupBy = groupBy
        }
    }
    
    // MARK: - Tableview
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.launchesInSections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "launchCell", for: indexPath)
        let launchViewModel = self.viewModel.launchesInSections[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = launchViewModel.missionName
        cell.detailTextLabel?.text = launchViewModel.date + " (" + launchViewModel.success + ")"
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sectionTitles.count
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.sectionTitles[section]
    }
    
    
    // MARK: - Actions
    
    @IBAction func filterBySuccessClicked(_ sender: UIBarButtonItem) {
        self.filterBySuccess(success: self.successFilter)
        self.successFilter = !self.successFilter
    }
    
    @IBAction func sortByNameClicked(_ sender: UIBarButtonItem) {
        self.sort(groupBy: .Name)
    }
    
    @IBAction func sortByDateClicked(_ sender: UIBarButtonItem) {
        self.sort(groupBy: .Date)
    }

}

