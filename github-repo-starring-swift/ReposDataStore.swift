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
   
   func toggleStarStatusForRepository(repository: GithubRepository, completion: () -> Void) {
      GithubAPIClient.checkIfRepositoryIsStarred(repository.fullName) { response in
         if response {
            GithubAPIClient.unStarRepository(repository.fullName, completion: {
               print("It was unstarred")
            })
            completion()
         } else if !response {
            GithubAPIClient.starRepository(repository.fullName, completion: {
               print("It was starred")
            })

            completion()
         } else {
            print("There was some kind of error unstarring/starring")
         }
      }
   }
}

///from solution repo
//class ReposDataStore {
//
//    static let sharedInstance = ReposDataStore()
//    private init() {}
//
//    var repositories:[GithubRepository] = []
//
//    func getRepositoriesWithCompletion(completion: () -> ()) {
//        GithubAPIClient.getRepositoriesWithCompletion { (reposArray) in
//            self.repositories.removeAll()
//            for dictionary in reposArray {
//                guard let repoDictionary = dictionary as? NSDictionary else { fatalError("Object in reposArray is of non-dictionary type") }
//                let repository = GithubRepository(dictionary: repoDictionary)
//                self.repositories.append(repository)
//
//            }
//            completion()
//        }
//    }
//
//}
