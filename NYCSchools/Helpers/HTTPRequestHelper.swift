//
//  HTTPRequestHelper.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/26/22.
//

import Foundation

// Enum for HTTPMethods
enum HTTPMethod: String {
    case GET
    case POST
}

// MARK: - HttpRequestHelper
/**
 Common class to make an service request using URLSession
 */
class HttpRequestHelper {

    func GET(url: String, params: [String: String], httpMethod: HTTPMethod = .GET, complete: @escaping (Bool, Data?) -> ()) {
        guard var components = URLComponents(string: url) else {
            print(Constants.urlComponentError)
            return
        }
        if params.count > 0 {
            components.queryItems = params.map { key, value in
                return URLQueryItem(name: key, value: value)
            }
        }
        
        guard let url = components.url else {
            print(Constants.urlCreationErrror)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        // .ephemeral prevent JSON from caching (They'll store in RAM and nothing in Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error as Any)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print(Constants.urlResponseDataError)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                complete(false, nil)
                return
            }
            complete(true, data)
        }.resume()
    }
}
