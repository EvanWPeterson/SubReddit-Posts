//
//  SubRedditPostsTableViewController.swift
//  SubReddit-Posts
//
//  Created by Evan Peterson on 1/30/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit
import Foundation

class SubRedditPostsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchTextField: UISearchBar!
    
    
    
    var results: [Post] = [] {
        didSet {
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
//        searchTextField.showsCancelButton = true
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else { return }
        
        searchBar.resignFirstResponder()
                
        PostController.searchForPosts(searchTerm: term) { (post) in
            
                self.results = post
        }
        
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        PostController.clearSearch()
//        tableView.reloadData()
//    }

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubRedditPostCell", for: indexPath)
        
        let post = results[indexPath.row]
        cell.textLabel?.text = post.title
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webView" {
            guard let nextVC = segue.destination as? WebViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let post = PostController.shared.post[indexPath.row]
            nextVC.urlString = post.url
        }
    }
 
}
