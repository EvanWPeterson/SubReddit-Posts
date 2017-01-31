//
//  NetWorkController.swift
//  SubReddit-Posts
//
//  Created by Evan Peterson on 1/30/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation
class NetworkController {
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case patch = "PATCH"
        case Delete = "DELETE"
        
    }
    // requesting information from the url
    static func performRequest(for url: URL,
                               httpMethod: HTTPMethod,
                               urlParameters: [String:String]? = nil,
                               body: Data? = nil,
                               completion: ((Data?, Error?) -> Void)? = nil) {
        
        // Here we are creating our url that we are requesting data drom
        let requestURL = self.url(byAdding: urlParameters, to: url)
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        // We use data task to get data from a specified URL (request)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, URLResponse, error) in
            completion?(data, error)
            
        }
        
        // This actually executes the dataTask
        dataTask.resume()
    }
    
    // perfom request
    // this ads parameters to the base url
    static func url(byAdding parameters: [String: String]?, to url: URL) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        components?.queryItems = parameters?.flatMap({URLQueryItem(name: $0.0, value: $0.1)})
        
        guard let url = components?.url else {
            fatalError("URL optional is nil")
            
        }
        return url
    }
    
}
