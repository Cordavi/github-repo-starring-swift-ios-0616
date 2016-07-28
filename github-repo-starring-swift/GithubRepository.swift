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

