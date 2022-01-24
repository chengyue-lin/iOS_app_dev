//
//  Animal.swift
//  It's a Zoo in There
//
//  Created by Ian on 2022/1/21.
//

import Foundation
import UIKit

class Animal: CustomStringConvertible {
    
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    
    init(nam: String, spec: String, a: Int, im: UIImage, sp: String) {
            name = nam
            species = spec
            age = a
            image = im
            soundPath = sp
        }
        
    var description: String {
        return "Animal: name = \(name), species = \(species), age = \(age)"
    }
}
