//
//  LaunchDetailViewController.swift
//  TABAssignment
//
//  Created by Sean Guo on 8/12/19.
//  Copyright © 2019 Sean Guo. All rights reserved.
//

import UIKit

class LaunchDetailViewController: UITableViewController {
    
    var flightNumber: Int = -1
    
    private var viewModel: LaunchDetailViewModel = LaunchDetailViewModel() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.fetchLaunchDetail()
    }
    
    func setupUI() {
        self.title = self.viewModel.title
    }
    
    func setupViewModel(launch: Launch) {
        self.viewModel = LaunchDetailViewModel(launch: launch)
    }
    
    // MARK: - Data
    
    func fetchLaunchDetail() {
        LocalDataStore.sharedInstance.fetchOneLaunch(flightNumber: self.flightNumber) { (launch, error) in
            guard let launch = launch else { return }
            self.setupViewModel(launch: launch)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.infoInSections[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        
        cell.textLabel?.text = self.viewModel.infoInSections[indexPath.section][indexPath.row]
        return cell
    }

}
