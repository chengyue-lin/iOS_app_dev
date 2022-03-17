//
//  cityModels.swift
//  finalProject
//
//  Created by Ian on 2022/3/8.
//

import Foundation


struct City: Codable, Hashable{
    let name: String?
    let country: String?
    let lat: String?
    let lng: String?
    
}

struct City_lat: Codable, Hashable{
    let name: String?
    let country: String?
    let lat: Float?
    let lon: Float?
    
}
