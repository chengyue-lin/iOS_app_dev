//
//  DetailViewController.swift
//  Project6
//
//  Created for MPCS 501030
//

import UIKit
import SafariServices
class DetailViewController: UIViewController {

    //
    // MARK: - IBOutlets
    //
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!

    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var releaseDateLabel: UILabel!
    
    var movie: Movie!

    //
    // MARK: - Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie.trackName
        ratingLabel.text = "Rated \(String(describing: movie.contentAdvisoryRating?.displayString))"
        priceLabel.text = "\(String(describing: movie.trackPrice!))"
        releaseDateLabel.text = "Release Date: \(String(describing: movie.releaseDate!))"
        descriptionTextView.text = movie.longDescription
        posterImage.image = MovieClient.cache.object(forKey: (movie.artworkUrl100! as NSString))
    }

    //
    // MARK: - IBActions
    //
    // write this function for opening the preview video.
    /// Open the current movie preview in Safari using system `UIApplication` method
    /// - Parameter sender: The button that was tapped
    /// https://www.youtube.com/watch?v=zMWrL2RoXVw  reference
    @IBAction func openSafari(_ sender: UIBarButtonItem) {
        //FIXME: Link to Safari to show preview
        let preview = SFSafariViewController(url: movie.previewUrl!)
        self.present(preview, animated: true, completion: nil)
    }
}
