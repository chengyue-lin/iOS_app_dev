//
//  ViewController.swift
//  My Kind of Town
//
//  Created by Ian on 2022/2/12.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var myTitle: UILabel!
    @IBOutlet var myDesc: UILabel!
    @IBOutlet var favButton: UIButton!
    @IBOutlet var starBu: UIButton!
    
    
    @IBAction func starButton(_ sender: UIButton){
        if sender.isSelected{
            DataManager.sharedInstance.deleteFavorite(name: myTitle.text!)
            sender.isSelected = false
        }else{
            DataManager.sharedInstance.saveFavorites(name: myTitle.text!)
            sender.isSelected = true
        }
        //sender.isSelected = !sender.isSelected
    }
    
    
    func loadData(){
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!){
            if let region = plist["region"] as? [NSNumber] {
                let coordinate = CLLocationCoordinate2D(latitude: region[0].doubleValue, longitude: region[1].doubleValue)
                let span = MKCoordinateSpan.init(latitudeDelta: region[2].doubleValue, longitudeDelta: region[3].doubleValue)
                mapView.region = MKCoordinateRegion.init(center: coordinate, span: span)
            }
            if let places = plist["places"] as? [NSDictionary] {
                for curPlace in places{
                    let place = Place()
                    place.coordinate = CLLocationCoordinate2DMake(curPlace["lat"] as! Double, curPlace["long"] as! Double)
                    place.name = curPlace["name"] as? String
                    place.longDescription = curPlace["description"] as? String
                    mapView.addAnnotation(place)
                    
                }

            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        
        
        mapView.register(PlaceMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadData()
        starBu.setImage(UIImage(systemName: "star.fill"), for: .selected)
        let list = DataManager.sharedInstance.listFavorites()
        starBu.setImage(UIImage(systemName: "star"), for: .normal)
        for pls in list{
            if pls == "Wrigley Field"{
                starBu.isSelected = true
                break
            }else{
                starBu.isSelected = false
            }
        }
        favButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
    }
    @objc func tapButton(_ gestureRecognizer: UIGestureRecognizer){
        let favoritesViewController = self.storyboard?.instantiateViewController(identifier: "FavoritesViewController") as! FavoritesViewController
        favoritesViewController.delegate = self
        if let presentationController = favoritesViewController.presentationController as? UISheetPresentationController{
            presentationController.detents = [.medium(), .large()]
            presentationController.largestUndimmedDetentIdentifier = .medium
            presentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            presentationController.prefersEdgeAttachedInCompactHeight = true
            presentationController.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(favoritesViewController, animated: true, completion: nil)
    }
}



extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        if let annotation = view.annotation as? Place{
            myTitle.text = annotation.name
            myDesc.text = annotation.longDescription
            // if the place is favorite or not
            let list = DataManager.sharedInstance.listFavorites()
            for pls in list{
                if pls == annotation.name{
                    print("found the place in the list")
                    starBu.isSelected = true
                    return
                }
            }
        }
        starBu.isSelected = false
    }
}

protocol PlacesFavoritesDelegate: AnyObject {
    func favoritePlace(name: String) -> Void
}
extension ViewController: PlacesFavoritesDelegate {
  
  func favoritePlace(name: String) {
   // Update the map view region based on the favorite place string in `name`
      if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!){
          if let places = plist["places"] as? [NSDictionary] {
              for curPlace in places{
                  if curPlace["name"] as! String == name{
                      let coordinate = CLLocationCoordinate2DMake(curPlace["lat"] as! Double, curPlace["long"] as! Double)
                      
                      let span = MKCoordinateSpan(latitudeDelta: 0.00978871051851371, longitudeDelta: 0.008167393319212124)
                      let region = MKCoordinateRegion(center: coordinate, span: span)
                      mapView.setRegion(region, animated: true)
                      myTitle.text = name
                      myDesc.text = curPlace["description"] as? String
                      
                      starBu.isSelected = true
                  }
              }
          }
      }
  }
}
