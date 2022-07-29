//
//  SchoolsService.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/26/22.
//

import Foundation

/**
 Common protocol interface for service request
 */
protocol SchoolsServiceProtocol {
    func getSchools(completion: @escaping (_ success: Bool, _ results: Schools?, _ error: String?) -> ())
    func getSchoolDetail(dbn: String, completion: @escaping (_ success: Bool, _ results: SchoolSATDetail?, _ error: String?) -> ())
}

// MARK: - SchoolsService

class SchoolsService: SchoolsServiceProtocol {
    
    // Get Schools list from API
    func getSchools(completion: @escaping (Bool, Schools?, String?) -> ()) {
        HttpRequestHelper().GET(url: Constants.schoolListAPI, params: [:], httpMethod: HTTPMethod.GET) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Schools.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, Constants.apiJsonParseError)
                }
            } else {
                completion(false, nil, Constants.urlRequestFailError)
            }
        }
    }
    
    // Get School SAT details from API
    func getSchoolDetail(dbn: String, completion: @escaping (Bool, SchoolSATDetail?, String?) -> ()) {
        HttpRequestHelper().GET(url: Constants.schoolDetailAPI, params: [Constants.dbn: dbn], httpMethod: HTTPMethod.GET) { success, data in
            if success {
                do {
                    guard let data = data else {
                        print(Constants.urlResponseDataError)
                        completion(false, nil, nil)
                        return
                    }
                    let model = try JSONDecoder().decode([SchoolSATDetail].self, from: data)
                    completion(true, (model.count > 0) ? model[0] : nil, nil)
                } catch(let error) {
                    print("Error: \(error)")
                    completion(false, nil, Constants.apiJsonParseError)
                }
            } else {
                completion(false, nil, Constants.urlRequestFailError)
            }
        }
    }
}
