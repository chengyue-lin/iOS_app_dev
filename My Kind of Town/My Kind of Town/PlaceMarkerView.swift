//
//  PlaceMarkerView.swift
//  My Kind of Town
//
//  Created by Ian on 2022/2/13.
//

import UIKit
import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {

    
    override var annotation: MKAnnotation? {
          willSet {
            clusteringIdentifier = "Place"
            displayPriority = .defaultLow
            markerTintColor = .systemRed
            glyphImage = UIImage(systemName: "pin.fill")
            }
      }
    
}
