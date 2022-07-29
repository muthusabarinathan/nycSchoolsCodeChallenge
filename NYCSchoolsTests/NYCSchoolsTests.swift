//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//
//  Created by Muthu Sabarinathan on 7/26/22.
//

import XCTest
@testable import NYCSchools

class NYCSchoolsTests: XCTestCase {

    let service = SchoolsService()
    
    func testAlbumViewControllerLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let schoolsListViewController = storyboard.instantiateViewController(withIdentifier: "SchoolsListViewController") as? SchoolsListViewController
        
        XCTAssert((schoolsListViewController != nil), "Controller existed")
    }
    
    func testGetSchoolList() {
        service.getSchools() { success, model, error in
            XCTAssertTrue((model!.count > 0), "Fetched API response")
        }
    }
    
    func testGetSchoolDetail() {
        service.getSchoolDetail(dbn: "21K728") { success, model, error in
            if let schoolSAT = model {
                XCTAssertTrue(schoolSAT.dbn == "21K728", "Fetched API response")
            }
        }
    }
}




