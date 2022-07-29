//
//  SchoolDetailViewModel.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/27/22.
//

import Foundation

// MARK: - SchoolsListViewModel

/**
 SchoolDetailViewModel is a viewModel that interacts with school SAT model and SchoolsListViewController
 */
class SchoolDetailViewModel: NSObject {
    
    // MARK: - Variables
    private var schoolService: SchoolsServiceProtocol
    var reloadTableView: (() -> Void)?
    var schoolSATDetail: SchoolSATDetail?
    var schoolInformation: School?
    var schoolDetailCellData = [SchoolDetailCellData]()
    var cellVM: SchoolDetailCellData?
    
    var schoolName: String? {
        return ((schoolSATDetail?.schoolName) != nil) ? schoolSATDetail?.schoolName : schoolInformation?.schoolName
    }
    var overview: String? {
        return ((schoolInformation?.overView) != nil) ? schoolInformation?.overView : Constants.notAvailable
    }
    var eligibility: String? {
        return ((schoolInformation?.eligibility) != nil) ? schoolInformation?.eligibility : Constants.notAvailable
    }
    var numberOfSATTestTakers: String? {
        return ((schoolSATDetail?.numOfSATTestTakers) != nil) ? schoolSATDetail?.numOfSATTestTakers : Constants.notAvailable
    }
    var avgMathScore: String? {
        return ((schoolSATDetail?.avgMathScore) != nil) ? schoolSATDetail?.avgMathScore : Constants.notAvailable
    }
    var avgReadingScore: String? {
        return ((schoolSATDetail?.avgReadingScore) != nil) ? schoolSATDetail?.avgReadingScore : Constants.notAvailable
    }
    var avgWritingScore: String? {
        return ((schoolSATDetail?.avgWritingScore) != nil) ? schoolSATDetail?.avgWritingScore : Constants.notAvailable
    }
    var websiteLink: String? {
        let websiteTxt = (schoolInformation?.websiteLink != nil) ? schoolInformation?.websiteLink : Constants.notAvailable
        return "Website : \(websiteTxt ?? Constants.notAvailable)"
    }
    var address: String? {
        let fullAddress: String = [schoolInformation?.primaryAddressLine, schoolInformation?.city, schoolInformation?.state, schoolInformation?.zip].compactMap({ $0 }).joined(separator: ", ")
        return fullAddress
    }
    var phoneNumber: String? {
        let phoneTxt = (schoolInformation?.phoneNumber != nil) ? schoolInformation?.phoneNumber : Constants.notAvailable
        return "Phone : \(phoneTxt ?? Constants.notAvailable)"
    }
    var email: String? {
        let emailTxt = (schoolInformation?.email != nil) ? schoolInformation?.email : Constants.notAvailable
        return "Email : \(emailTxt ?? Constants.notAvailable)"
    }
    var timing: String? {
        let fullTiming: String = [schoolInformation?.startTiming, schoolInformation?.endTiming].compactMap({ $0 }).joined(separator: Constants.schoolTimeJoin)
        return "School Timing : \(String(describing: fullTiming))"
    }
    
    // Initialize viewModel with Service
    init(schoolService: SchoolsServiceProtocol = SchoolsService()) {
        self.schoolService = schoolService
    }
    
    // Get school SAT details from API
    func getSchoolDetail(dbn: String) {
        schoolService.getSchoolDetail(dbn: dbn) { success, model, error in
            if let schoolSAT = model {
                self.schoolSATDetail = schoolSAT
            }
            var vms = [SchoolDetailCellData]()
            vms.append(self.createCellModel())
            self.schoolDetailCellData = vms
            self.cellVM = self.createCellModel()
            self.reloadTableView?()
        }
    }
    
    // Creating cell model to bind the data in TableViewCell
    func createCellModel() -> SchoolDetailCellData {
        return SchoolDetailCellData(schoolName: schoolName, overview: overview, eligibility: eligibility, numberOfSATTestTakers: numberOfSATTestTakers, avgMathScore: avgMathScore, avgReadingScore: avgReadingScore, avgWritingScore: avgWritingScore, websiteLink: websiteLink, address: address, phoneNumber: phoneNumber, email: email, timing:timing, detailViewModel: self)
    }
    
    // Getting specific school information from an array
    func getCellViewModel() -> SchoolDetailCellData {
        return schoolDetailCellData[0]
    }
}
