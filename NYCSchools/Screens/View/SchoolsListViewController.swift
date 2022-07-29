//
//  SchoolsListViewController.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/26/22.
//

import UIKit

// MARK: - SchoolsListViewController Class

/**
 SchoolsListViewController displays Schools list got from API response.
*/
class SchoolsListViewController: UIViewController {

    // MARK: - Variables
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noRecordFound: UILabel!
    
    lazy var viewModel = { SchoolsListViewModel() }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize View Model
        initViewModel()
        
        // Initialize TableView
        initTableView()
        
    }

    func initTableView() {
        // Registering NIB to tableview
        tableView.register(SchoolListCell.nib, forCellReuseIdentifier: SchoolListCell.identifier)
    }

    func initViewModel() {
        // Showing Activity Indicator until getting API response
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // Get schools list data from API
        viewModel.getSchoolsList()
        
        // Reload TableView
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                // Updating UI based on Data availability
                if (self?.viewModel.schoolListCellData.count)! <= 0 {
                    self?.noRecordFound.isHidden = false
                }
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SchoolDetailViewController {
            let schoolDetailVC = segue.destination as? SchoolDetailViewController
            schoolDetailVC?.viewModel.schoolInformation = viewModel.schoolsOrdered[sender as! Int]
        }
    }
    
    @IBAction func sortTapped(_ sender: Any) {
        var sortRawValue: Int = viewModel.sortOrder.rawValue
        sortRawValue += 1
        if sortRawValue > 2 {
            sortRawValue = 0
        }
        if let newSortOrder = SchoolOrder(rawValue: sortRawValue) {
            viewModel.sortOrder = newSortOrder
        }
        
        viewModel.sortTheData()
        // Reload TableView
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension SchoolsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.schoolListRowSize)
    }
}

// MARK: - UITableViewDataSource
extension SchoolsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schoolListCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolListCell.identifier, for: indexPath) as? SchoolListCell else { fatalError(Constants.xibError)}
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.segueIdentifier, sender: indexPath.row)
    }
}
