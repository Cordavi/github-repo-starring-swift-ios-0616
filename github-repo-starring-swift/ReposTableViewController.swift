//
//  ReposTableViewController.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
   let dataStore = ReposDataStore.sharedInstance
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      
      ///////////
      let urlString = "\(APIKeys.gitHubAddress)" + "user/starred" + "/\(fullName)" + "\(APIKeys.clientID)" + "\(APIKeys.clientSecret)" + "\(APIKeys.urlAccessToken)"
      
      guard let repoStarredURL = NSURL(string: urlString) else {
         return
      }
      
      let urlSession = NSURLSession.sharedSession()
      urlSession.dataTaskWithURL(repoStarredURL) { data, response, error in
         <#code#>
         }.resume()

      
      
      //////////////
      
      
      self.tableView.accessibilityLabel = "tableView"
      self.tableView.delegate = self
      
      dataStore.getRepositoriesWithCompletion {
         dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
         }
         
      }
   }
   
   // MARK: - Table view data source
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataStore.repositories.count
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)
      
      cell.textLabel?.text = dataStore.repositories[indexPath.row].fullName
      return cell
   }
   
}

///from solution repo
//class ReposTableViewController: UITableViewController {
//    
//    let store = ReposDataStore.sharedInstance
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.tableView.accessibilityLabel = "tableView"
//        self.tableView.accessibilityIdentifier = "tableView"
//        
//        store.getRepositoriesWithCompletion {
//            NSOperationQueue.mainQueue().addOperationWithBlock({ 
//                self.tableView.reloadData()
//            })
//        }
//    }
//
//    // MARK: - Table view data source
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.store.repositories.count
//    }
//
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)
//
//        let repository:GithubRepository = self.store.repositories[indexPath.row]
//        cell.textLabel?.text = repository.fullName
//
//        return cell
//    }
//
//}
