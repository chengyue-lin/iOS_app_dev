//
//  FiltersViewController.swift
//  Project6
//
//  Created for MPCS 501030
//

import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var ratingsControl: UISegmentedControl!
    @IBOutlet private var priceStepper: UIStepper!
    
    @IBOutlet var dateSwitch: UISwitch!
    // This is nil ; it needs to have a value of the movies viewcontroller
    weak var delegate: MoviesFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceLabel.text = "Less than: \(DataManager.sharedInstance.priceLimitDisplayString)"
        priceStepper.value = Double(DataManager.sharedInstance.priceLimitFilter)
        
        var selectedRatingIndex: Int
        if DataManager.sharedInstance.ratingFilter == "g" {
            selectedRatingIndex = 0
        } else if DataManager.sharedInstance.ratingFilter == "pg" {
            selectedRatingIndex = 1
        } else if DataManager.sharedInstance.ratingFilter == "pg13" {
            selectedRatingIndex = 2
        } else if DataManager.sharedInstance.ratingFilter == "r" {
            selectedRatingIndex = 3
        } else {
            selectedRatingIndex = 4
        }
        ratingsControl.selectedSegmentIndex = selectedRatingIndex
    }
    
    @IBAction func ratingChanged(_ sender: UISegmentedControl) {
        guard Rating(rawValue: ratingsControl.selectedSegmentIndex) != nil else {
            return
        }
        
        let index = ratingsControl.selectedSegmentIndex
        var selectedRatingFilter: String
        if index == 0 {
            selectedRatingFilter = Rating.g.displayString
        } else if index == 1 {
            selectedRatingFilter = Rating.pg.displayString
        } else if index == 2 {
            selectedRatingFilter = Rating.pg13.displayString
            
        } else if index == 3 {
            selectedRatingFilter = Rating.r.displayString
        } else {
            selectedRatingFilter = Rating.anyRating.displayString
        }
        
        DataManager.sharedInstance.updateAllFactor(rating: selectedRatingFilter)
        delegate!.changeFilter(price: DataManager.sharedInstance.priceLimitFilter, rating: DataManager.sharedInstance.ratingFilter, switchOn: DataManager.sharedInstance.switchOn)
        
    }
    // change the list to sorted or unsorted.
    @IBAction func sortReleaseDate(_ sender: UISwitch) {
        if sender.isOn{
            
            delegate?.changeFilter(price: DataManager.sharedInstance.priceLimitFilter, rating: DataManager.sharedInstance.ratingFilter, switchOn: true)
        }else{
            delegate?.changeFilter(price: DataManager.sharedInstance.priceLimitFilter, rating: DataManager.sharedInstance.ratingFilter, switchOn: false)
        }
    }
    
    
    
 
    @IBAction func priceChanged(_ sender: UIStepper) {
        DataManager.sharedInstance.updateAllFactor(priceLimit: Float(sender.value))
        priceLabel.text = "Less than: \(DataManager.sharedInstance.priceLimitDisplayString)"
        delegate?.changeFilter(price: DataManager.sharedInstance.priceLimitFilter, rating: DataManager.sharedInstance.ratingFilter, switchOn: DataManager.sharedInstance.switchOn)
    }
}


