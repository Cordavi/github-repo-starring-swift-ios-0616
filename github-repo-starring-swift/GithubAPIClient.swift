//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit



class GithubAPIClient {
   
   
   class func getRepositoriesWithCompletion(completion: [[String : AnyObject]] -> Void) {
      let urlString = "\(GitHutWebPaths.gitHubAddress)" + "repositories" + "\(APIKeys.clientID)" + "\(APIKeys.clientSecret)"
      
      guard let url = NSURL(string: urlString) else {
         return
      }
      
      let urlSession = NSURLSession.sharedSession()
      urlSession.dataTaskWithURL(url) { data, response, error in
         guard let data = data where error == nil else {
            return
         }
         
         do {
            let responseData = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [[String : AnyObject]]
            if let responseData = responseData {
               completion(responseData)
            }
         } catch {
            print(error)
         }
         
         }.resume()
   }
   
   class func checkIfRepositoryIsStarred(fullName: String, completion: Bool -> Void) {
      let urlString = "\(GitHutWebPaths.gitHubAddress)" + "\(GitHutWebPaths.gitHubStarred)" + "\(fullName)"
      
      guard let repoStarredURL = NSURL(string: urlString) else {
         return
      }
      
      let request = NSMutableURLRequest(URL: repoStarredURL)
      request.HTTPMethod = "GET"
      request.addValue("\(APIKeys.headerAccessToken)", forHTTPHeaderField: "Authorization")
      
      let urlSession = NSURLSession.sharedSession()
      urlSession.dataTaskWithRequest(request) { _, response, _ in
         guard let httpResponse = response as? NSHTTPURLResponse else {
            return
         }
         
         if httpResponse.statusCode == 404 {
            completion(false)
         } else if httpResponse.statusCode == 204 {
            completion(true)
         } else {
            print("Other status code \(httpResponse.statusCode)")
         }
         
         }.resume()
   }
   
   class func starRepository(fullName: String, completion: () -> Void) {
      let urlString = "\(GitHutWebPaths.gitHubAddress)" + "\(GitHutWebPaths.gitHubStarred)" + "\(fullName)"
      
      guard let repoStarredURL = NSURL(string: urlString) else {
         return
      }
      
      let request = NSMutableURLRequest(URL: repoStarredURL)
      request.HTTPMethod = "PUT"
      request.addValue("\(APIKeys.headerAccessToken)", forHTTPHeaderField: "Authorization")
      
      let urlSession = NSURLSession.sharedSession()
      urlSession.dataTaskWithRequest(request) { _, response, _ in
         guard let httpResponse = response as? NSHTTPURLResponse else {
            return
         }
         
         if httpResponse.statusCode == 204 {
            completion()
         } else {
            print("Other status code \(httpResponse.statusCode)")
         }
         
         }.resume()
   }
   
   class func unStarRepository(fullName: String, completion: () -> Void) {
      let urlString = "\(GitHutWebPaths.gitHubAddress)" + "\(GitHutWebPaths.gitHubStarred)" + "\(fullName)"
      
      guard let repoStarredURL = NSURL(string: urlString) else {
         return
      }
      
      let request = NSMutableURLRequest(URL: repoStarredURL)
      request.HTTPMethod = "DELETE"
      request.addValue("\(APIKeys.headerAccessToken)", forHTTPHeaderField: "Authorization")
      
      let urlSession = NSURLSession.sharedSession()
      urlSession.dataTaskWithRequest(request) { _, response, _ in
         guard let httpResponse = response as? NSHTTPURLResponse else {
            return
         }
         
         if httpResponse.statusCode == 204 {
            completion()
         } else {
            print("Other status code \(httpResponse.statusCode)")
         }
         
         }.resume()
      
   }
}


