//
//  Constants.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/27/22.
//

import Foundation

/**
 Constants struct has all the constants static strings which are used in NYC Schools project.
 */
struct Constants {
    static let xibError = "xib does not exists"
    static let segueIdentifier = "detailSegue"
    static let schoolTimeJoin = " to "
    static let schoolListRowSize = 80
    static let schoolDetailRowCount = 3
    static let notAvailable = "N/A"
    static let dbn = "dbn"
    static let schoolListAPI = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    static let schoolDetailAPI = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    static let apiJsonParseError = "Error: Trying to parse data to model"
    static let urlRequestFailError = "Error: NYC Schools GET Request failed"
    static let urlComponentError = "Error: Cannot create URLComponents"
    static let urlCreationErrror = "Error: Cannot create URL"
    static let urlResponseDataError = "Error: Did not receive data"
}
