//
//  DataManager.swift
//  Project6
//
//  Created for MPCS 501030
//

import Foundation
class DataManager {
    //
    // MARK: - Singleton
    //
    public static let sharedInstance = DataManager()
    /// List of movies retrieved from iTunes, does not mutate with filters, maintains original fetch data
    private(set) var movies: [Movie]
    /// List of movies retrieved from iTunes, and then filtered based on user input
    private(set) var filteredMovies: [Movie]
    private(set) var priceLimitFilter: Float
    
    private(set) var ratingFilter: String
    private(set) var switchOn: Bool             // use a UISwitch to sort the release day
    var priceLimitDisplayString: String {
        return "$\(priceLimitFilter)"
    }
    // Init with default values
    private init() {
        priceLimitFilter = 20
        ratingFilter = "anyRating"
        movies = []
        filteredMovies = []
        switchOn = false
    }
    func refreshMovieData(_ movies: [Movie]) {
        self.movies = movies
        self.filteredMovies = movies
    }
    func updateFiltered(_ filteredMovies: [Movie]) {
        self.filteredMovies = filteredMovies
    }
    // change the name of function as update the parameters.
    func updateAllFactor(priceLimit: Float? = nil, rating: String? = nil, switchCase: Bool? = false) {
        if let priceLimit = priceLimit {
            self.priceLimitFilter = priceLimit
        }
        
        if let rating = rating {
            self.ratingFilter = rating
        }
        if let switchCase = switchCase {
            self.switchOn = switchCase
        
        }
    }
}
