//
//  GithubRepository.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubRepository {
   let fullName: String
   let htmlURL: NSURL
   let repositoryID: String
   
   init(dictionary: [String: AnyObject]) {
      fullName = dictionary["full_name"] as? String ?? ""
      htmlURL = NSURL(string: (dictionary["html_url"] as? String ?? "")) ?? NSURL()
      repositoryID = (dictionary["id"] as? NSNumber)?.stringValue ?? ""
   }
}

//////from solution repo
//class GithubRepository {
//    var fullName: String
//    var htmlURL: NSURL
//    var repositoryID: String
//    
//    init(dictionary: NSDictionary) {
//        guard let
//            name = dictionary["full_name"] as? String,
//            valueAsString = dictionary["html_url"] as? String,
//            valueAsURL = NSURL(string: valueAsString),
//            repoID = dictionary["id"]?.stringValue
//            else { fatalError("Could not create repository object from supplied dictionary") }
//        
//        htmlURL = valueAsURL
//        fullName = name
//        repositoryID = repoID
//    }
//    
//}
