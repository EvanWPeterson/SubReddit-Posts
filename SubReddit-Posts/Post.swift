//
//  Post.swift
//  SubReddit-Posts
//
//  Created by Evan Peterson on 1/30/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation

class Post {
    
    let kTitle = "display_name"
    let kUrl = "url"
    
    let title: String
    let url: String
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
        
    }
    
    init?(dictionary: [String: Any]) {
        guard let title = dictionary[kTitle] as? String,
        let url = dictionary[kUrl] as? String else { return nil}
        
        self.title = title
        self.url = url
        
    }
}
