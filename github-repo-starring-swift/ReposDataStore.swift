//
//  ReposDataStore.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit


class ReposDataStore {
   
   static let sharedInstance = ReposDataStore()
   var repositories = [GithubRepository]()
   
   func getRepositoriesWithCompletion(completion: () -> Void){
      GithubAPIClient.getRepositoriesWithCompletion { responseData in
         ReposDataStore.sharedInstance.repositories.removeAll()
         
         for repository in responseData {
            self.repositories.append(GithubRepository(dictionary: repository))
         }
         completion()
      }
   }
   
   func toggleStarStatusForRepository(repository: GithubRepository, completion: Bool -> Void) {
      GithubAPIClient.checkIfRepositoryIsStarred(repository.fullName) { response in
         if response {
            GithubAPIClient.unStarRepository(repository.fullName, completion: {
               completion(false)
               }
            )
         } else if !response {
            GithubAPIClient.starRepository(repository.fullName, completion: {
               completion(true)
               }
            )
         } else {
            print("There was some kind of error unstarring/starring")
         }
      }
   }
}

