//
//  SchoolsListViewModel.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/26/22.
//

import Foundation

// MARK: - SchoolsListViewModel

enum SchoolOrder: Int {
    case ascending = 0
    case descending
    case random
}

/**
 SchoolsListViewModel is a viewModel that interacts with school model and SchoolsListViewController
 */
class SchoolsListViewModel: NSObject {
    
    // MARK: - Variables
    private var schoolService: SchoolsServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var schools = Schools()
    var schoolsOrdered = Schools()
    var schoolListCellData = [SchoolListCellData]() {
        didSet{
            reloadTableView?()
        }
    }
    var sortOrder: SchoolOrder = .random
    
    // Initialize viewModel with Service
    init(schoolService: SchoolsServiceProtocol = SchoolsService()) {
        self.schoolService = schoolService
    }
    
    // Fetch Schools list from API
    func getSchoolsList() {
        schoolService.getSchools { success, model, error in
            if success, let schoolLists = model {
                self.schools = schoolLists
                self.fetchData(schools: schoolLists, sortOrder: .random)
            } else {
                print(error!)
            }
        }
    }
    
    // Sorting the list based on School name
    func fetchData(schools: Schools, sortOrder: SchoolOrder = .random) {
        switch sortOrder {
        case .random:
            schoolsOrdered = schools
            break
        case .ascending:
            schoolsOrdered = schools.sorted(by: { $0.schoolName! < $1.schoolName!})
            break
        case .descending:
            schoolsOrdered = schools.sorted(by: { $0.schoolName! > $1.schoolName!})
            break
        }
        
        var vms = [SchoolListCellData]()
        for school in schoolsOrdered {
            if let cellModel = createCellModel(school: school) {
                vms.append(cellModel)
            }
        }
        schoolListCellData = vms
    }
    
    // Creating cell model to bind the data in TableViewCell
    func createCellModel(school: School) -> SchoolListCellData? {
        guard let schoolName = school.schoolName else { return nil }
        return SchoolListCellData(schoolName: schoolName)
    }
    
    // Getting specific school detail from an array
    func getCellViewModel(at indexPath: IndexPath) -> SchoolListCellData {
        return schoolListCellData[indexPath.row]
    }
    
    func sortTheData() {
        fetchData(schools: self.schools, sortOrder: sortOrder)
    }
}

