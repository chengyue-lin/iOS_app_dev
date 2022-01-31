//
//  GithubClient.swift
//  You've Got Issues!
//
//  Created by Ian on 2022/1/30.
//

import UIKit

import Foundation

struct GithubIssue: Codable {
    let title: String?
    let createdAt: String
    let body: String?
    let state: String
    let user: GitHubUser
}

struct GitHubUser:Codable {
    let login: String
}

class GitHubClient {
  
    static func fetchIssues(state: String, completion: @escaping ([GithubIssue]?, Error?) -> Void) {
    
    // Set the URL
    let url = URL(string: "https://api.github.com/repos/ethereum/solidity/issues?state=\(state)")!
    
    // Create a data task
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      
      guard let data = data, error == nil else {
        // If we are missing data, send back no data with an error
        DispatchQueue.main.async { completion(nil, error) }
        return
      }
      
      // Safely try to decode the JSON to our custom struct
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let issues = try decoder.decode([GithubIssue].self, from: data)

        // If we're successful, send back our releases with no error
        //
        //
        DispatchQueue.main.async { completion(issues, nil) }

      } catch (let parsingError) {
        DispatchQueue.main.async { completion(nil, parsingError) }
      }
    }
    
    // Start the task (it begins suspended)
    task.resume()
  }
}

