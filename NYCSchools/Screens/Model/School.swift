//
//  School.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/26/22.
//

import Foundation

typealias Schools = [School]

// MARK: - School
struct School: Codable {
    let dbn: String?
    let schoolName: String?
    let overView: String?
    let eligibility: String?
    let primaryAddressLine: String?
    let city: String?
    let zip: String?
    let state: String?
    let phoneNumber: String?
    let email: String?
    let websiteLink: String?
    let startTiming: String?
    let endTiming: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
        case overView = "overview_paragraph"
        case eligibility = "eligibility1"
        case primaryAddressLine = "primary_address_line_1"
        case city = "city"
        case zip = "zip"
        case state = "state_code"
        case phoneNumber = "phone_number"
        case email = "school_email"
        case websiteLink = "website"
        case startTiming = "start_time"
        case endTiming = "end_time"
    }
}

// MARK: - School Detail
struct SchoolSATDetail: Codable {
    let dbn: String?
    let schoolName: String?
    let numOfSATTestTakers: String?
    let avgMathScore: String?
    let avgReadingScore: String?
    let avgWritingScore: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
        case numOfSATTestTakers = "num_of_sat_test_takers"
        case avgReadingScore = "sat_critical_reading_avg_score"
        case avgMathScore = "sat_math_avg_score"
        case avgWritingScore = "sat_writing_avg_score"
    }
}
