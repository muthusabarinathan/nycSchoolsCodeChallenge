//
//  SchoolDetailViewController.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/27/22.
//

import UIKit

// MARK: - SchoolsListViewController Class

/**
 SchoolDetailViewController displays Schools detials got from API response.
*/
class SchoolDetailViewController: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel = {
        SchoolDetailViewModel()
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize View Model
        initViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Initialize table view
        initTableView()
    }
    
    func initTableView() {
        // Registering NIBs to tableview
        self.tableView.register(SchoolDetailHeaderCell.nib, forCellReuseIdentifier: SchoolDetailHeaderCell.identifier)
        self.tableView.register(SchoolDetailCell.nib, forCellReuseIdentifier: SchoolDetailCell.identifier)
        self.tableView.register(SchoolCommunicationCell.nib, forCellReuseIdentifier: SchoolCommunicationCell.identifier)
    }
    
    func initViewModel() {
        // Showing Activity Indicator until getting API response
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // Get schools details data based on dbn from API
        guard let dbn = viewModel.schoolInformation?.dbn else { return }
        viewModel.getSchoolDetail(dbn: dbn)
        
        // Reload TableView
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                // Updating UI based on Data availability
                self?.tableView.reloadData()
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension SchoolDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension SchoolDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.schoolDetailRowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Binding the data to UI
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailHeaderCell.identifier, for: indexPath) as? SchoolDetailHeaderCell else { fatalError(Constants.xibError)}
            cell.cellViewModel = viewModel.cellVM
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolDetailCell.identifier, for: indexPath) as? SchoolDetailCell else { fatalError(Constants.xibError)}
            cell.cellViewModel = viewModel.cellVM
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolCommunicationCell.identifier, for: indexPath) as? SchoolCommunicationCell else { fatalError(Constants.xibError)}
            cell.cellViewModel = viewModel.cellVM
            return cell
        }
    }
}
