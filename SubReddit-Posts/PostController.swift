//
//  PostController.swift
//  SubReddit-Posts
//
//  Created by Evan Peterson on 1/30/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation

class PostController {
    
    static let shared = PostController()
    
    var post: [Post] = []
    
    static let json = ".json"
    static let baseURL = "https://www.reddit.com/subreddits/search" + "\(json)"
    
//    func clearSearch() {
//        self.post = []
//    }
    
    static func searchForPosts(searchTerm: String, completion: @escaping ([Post]) -> Void) {
        let urlParams = ["q" : searchTerm]
        guard let url = URL(string: baseURL) else {
            completion([])
            return }
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: urlParams, body: nil) { (data, error) in
            guard let data = data, let response = String(data: data, encoding: .utf8) else {
                print("Error performing network request")
            completion([])
            return
            }
            
            guard let responseDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String : Any] else {
                print("\(response)")
                completion([])
                return
            }
            
            guard let dataDictionary = responseDictionary["data"] as? [String:Any],
                        let childrenDict = dataDictionary["children"] as? [[String:Any]] else {
                            print("Didnt get any results back")
                            completion([])
                            return }
            
            let finalResults = childrenDict.flatMap { $0["data"] as? [String : Any] }
            let endResults = finalResults.flatMap { Post.init(dictionary: $0) }
            completion(endResults)
            
        }
    }
}
