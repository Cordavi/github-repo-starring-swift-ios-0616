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
   
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      let repoSelected = dataStore.repositories[indexPath.row]
      dataStore.toggleStarStatusForRepository(repoSelected) { toggle in
         if toggle {
            let alertView = UIAlertController(title: "GitHub", message: "You just starred \(repoSelected.fullName)", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertView.addAction(okAction)
            alertView.accessibilityLabel = "You just starred \(repoSelected.fullName)"
            dispatch_async(dispatch_get_main_queue(), {
               self.presentViewController(alertView, animated: true, completion: nil)
               }
            )
         } else if !toggle {
            let alertView = UIAlertController(title: "GitHub", message: "You just unstarred \(repoSelected.fullName)", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertView.addAction(okAction)
            alertView.accessibilityLabel = "You just unstarred \(repoSelected.fullName)"
            dispatch_async(dispatch_get_main_queue(), {
               self.presentViewController(alertView, animated: true, completion: nil)
               }
            )
         }
      }
   }
}

