//
//  cityClient.swift
//  finalProject
//
//  Created by Ian on 2022/3/8.
//

import Foundation
import SwiftUI
class Citys: ObservableObject {
    /*
         This API is trying to get the city name within the U.S.. All the data contain in the local file which is called "cities.json" file. And it contain the latitude and longitude of the city which is good for us to use the latitude and longitude to get the weather data information.
         */
    
    @Published var allOfCity: [String] = []
    
    init() {
        
        let bundlePath = Bundle.main.url(forResource: "cities", withExtension: "json")
        
        let task = URLSession.shared.dataTask(with: bundlePath!) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let issues = try? JSONDecoder().decode([City].self, from: data)
            DispatchQueue.main.async {
                if let issues = issues {
                    for issue in issues{
                        self.allOfCity.append(issue.name ?? "default")
                    }
                }
        
            }
            
        }
        task.resume()
    }
}
