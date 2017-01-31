//
//  WebViewController.swift
//  SubReddit-Posts
//
//  Created by Evan Peterson on 1/30/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var WebView: UIWebView!
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        WebView.loadRequest(request)
        

    }
}
