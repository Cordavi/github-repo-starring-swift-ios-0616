//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
   
   class func getRepositoriesWithCompletion(completion: ([[String : AnyObject]] -> Void)) {
      let urlString = "https://api.github.com/repositories?client_id=" + "\(APIKeys.clientID)" + "&client_secret=" + "\(APIKeys.clientSecret)"
      
      guard let url = NSURL(string: urlString) else {
         return
      }
      
      let urlSession = NSURLSession.sharedSession()
      urlSession.dataTaskWithURL(url) {data, response, error in
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
}

///solution from repo
//class GithubAPIClient {
//    
//    class func getRepositoriesWithCompletion(completion: (NSArray) -> ()) {
//        let urlString = "\(githubAPIURL)/repositories?client_id=\(githubClientID)&client_secret=\(githubClientSecret)"
//        let url = NSURL(string: urlString)
//        let session = NSURLSession.sharedSession()
//        
//        guard let unwrappedURL = url else { fatalError("Invalid URL") }
//        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
//            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
//            
//            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSArray {
//                if let responseArray = responseArray {
//                    completion(responseArray)
//                }
//            }
//        }
//        task.resume()
//    }
//    
//}

