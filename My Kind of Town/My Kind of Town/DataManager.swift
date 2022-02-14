//
//  DataManager.swift
//  My Kind of Town
//
//  Created by Ian on 2022/2/13.
//

import Foundation
import MapKit

public class DataManager {
  
  // MARK: - Singleton Stuff
  public static let sharedInstance = DataManager()
    let defaults = UserDefaults.standard
    var favPlace: [String] = []
  //This prevents others from using the default '()' initializer
  private init() {
      defaults.register(defaults: ["favorites": []])
  }

  // Your code (these are just example functions, implement what you need)
    func loadAnnotationFromPlist() {
      if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!){
          if let places = plist["places"] as? [NSDictionary] {
              for curPlace in places{
                  favPlace.append((curPlace["name"] as? String)!)
              }

          }
      }
      
  }
    func saveFavorites(name: String) {
      var fav: [String] = defaults.object(forKey: "favorites") as? [String] ?? []
      fav.append(name)
        defaults.set(fav, forKey: "favorites")
        print("saved favorite: \(name)")
  }
    func deleteFavorite(name: String) {
        var fav: [String] = defaults.object(forKey: "favorites") as? [String] ?? []
      fav.removeAll(where: {$0 == name})
        defaults.set(fav, forKey: "favorites")
        print("deleted favorite: \(name)")
  }
  func listFavorites()-> [String] {
      return defaults.object(forKey: "favorites") as? [String] ?? []
  }
}
