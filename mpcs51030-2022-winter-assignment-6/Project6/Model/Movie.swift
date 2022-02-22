//
//  Movie.swift
//  Project6
//
//  Created for MPCS 501030
//

import Foundation

/// A list of the of `Movie` types
class movielist: Decodable{     // changed it to class since we need to do the data cache.
    let results: [Movie]
}

/// A move type with data matching the iTunes API (note that the names have historically music-like names)
struct Movie : Decodable, Hashable {
    let trackName: String?
    let trackPrice: Float?
    let contentAdvisoryRating: Rating?
    let artworkUrl100: String?
    let longDescription: String?
    let previewUrl: URL?
    let releaseDate: String?    // add it for storing the release date.

    var trackPrice_TOSTRING: String {
        if let trackPrice = trackPrice {
            return "$\(trackPrice)"
        } else {
            return "Unknown Price"
        }
    }
}


