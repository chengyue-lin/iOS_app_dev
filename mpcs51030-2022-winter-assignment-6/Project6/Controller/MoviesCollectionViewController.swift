//
//  MoviesCollectionViewController.swift
//  Project6
//
//  Created for MPCS 501030
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {
    static var cache_data = NSCache<NSString, movielist>()
    /// The collection view data source
    var dataSource: UICollectionViewDiffableDataSource<Int, Movie>!
    let userDefault = UserDefaults.standard
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up a search controller to show in the `NavigationBar`
        // Note that we are not using the full `SearchResults` functionality, we
        // are really only using it to present a `UISearchBar`
        let wantToSearch = (userDefault.string(forKey: "search") != nil) ? userDefault.string(forKey: "search")!: "love"
        let srchCtr = UISearchController(searchResultsController: nil)
        srchCtr.searchBar.delegate = self
        srchCtr.searchBar.text = wantToSearch
        srchCtr.searchBar.tintColor = UIColor.gray
        srchCtr.searchBar.showsCancelButton = true
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = srchCtr
        
        // Use the `MovieClient` to fetch a list of movies
        MovieClient.fetchMovies(searchQuery: wantToSearch) { [weak self] moviesData, error in
            guard let moviesData = moviesData, error == nil else {
                print(error ?? NSError())
                
                let result = MoviesCollectionViewController.cache_data.object(forKey: wantToSearch as NSString)
                DataManager.sharedInstance.refreshMovieData(result!.results)
                var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
                snapshot.appendSections([0])
                snapshot.appendItems(DataManager.sharedInstance.movies)
                
                return
            }
            MoviesCollectionViewController.cache_data.setObject(moviesData, forKey: wantToSearch as NSString)
            
            DataManager.sharedInstance.refreshMovieData(moviesData.results)
            /// Update the collection view based on the current state of the `data` property
            var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
            snapshot.appendSections([0])
            snapshot.appendItems(DataManager.sharedInstance.movies)
            
            self?.dataSource.apply(snapshot)
        }
        
        // Create the layout for the collection view
        collectionView.collectionViewLayout = makeLayout()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, state in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as! MoviesCollectionViewCell
            
            
            cell.setTitleLabel(state.trackName!)
            cell.setPriceLabel("\(String(describing: state.trackPrice!))")
            cell.setRatingLabel((state.contentAdvisoryRating?.displayString)!)
            // FIXME: Use the new iOS15 Asycn Image API and include a placeholder image
            cell.setImageView(UIImage(systemName: "swift")!)
            MovieClient.getImage ( url: state.artworkUrl100 ?? "", completion: { (image, error) in
                guard let image = image, error == nil else {
                    print(error ?? "")
                    return
                }
                cell.setImageView(image)
                cell.backgroundColor = MovieClient.averageColor(image: image)
                
            })
            
            return cell
        }
    
        /// Update the collection view based on the current state of the `data` property
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(DataManager.sharedInstance.movies)
        
        dataSource.apply(snapshot)
    }

}

//
// MARK: - Navigation
//

extension MoviesCollectionViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // There are two segue possible from this view controller: the popover filter or the detail view controller
        if segue.identifier == "popover" {
            let filtersViewController = segue.destination as? FiltersViewController
            filtersViewController?.delegate = self
            segue.destination.preferredContentSize = CGSize(width: 300, height: 250)
            if let presentationController = segue.destination.popoverPresentationController { // 1
                presentationController.delegate = self // 2
            }
        } else {
            guard let detailViewController = segue.destination as? DetailViewController,
                  let selectedRow = collectionView.indexPathsForSelectedItems?.first?.row else {
                return
            }
            detailViewController.movie = DataManager.sharedInstance.filteredMovies[selectedRow]
        }
    }
}

//
// MARK: - Protocol Extensions
//

extension MoviesCollectionViewController: UIPopoverPresentationControllerDelegate {
    
    /// Delegate method to enforce the correct popover style
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension MoviesCollectionViewController: MoviesFilterDelegate {
    
    

    // FIXME: Update the collection view based on the popover filters (including the release date)
    /// Update the collection view based on the popover filter selections
    func changeFilter(price: Float, rating: String, switchOn: Bool) {
        let filteredMovies = DataManager.sharedInstance.movies.filter { movie in
            let isBelowSelectedPriceLimit = movie.trackPrice! <= price
            let matchesSelectedRating = movie.contentAdvisoryRating?.displayString == rating || rating == "anyRating"
            
        
            return isBelowSelectedPriceLimit && matchesSelectedRating
        }
        // check the bool switchOn is true or false.
        if switchOn == true{
            let sortedList = filteredMovies.sorted{ $0.releaseDate! < $1.releaseDate! }
            DataManager.sharedInstance.updateFiltered(sortedList)
        }else{
            DataManager.sharedInstance.updateFiltered(filteredMovies)
        }
        //let isOnSwitch = sortReleaseDate()
        
        /// Update the collection view based on the current state of the `data` property
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(DataManager.sharedInstance.filteredMovies)
        
        dataSource.apply(snapshot)
        
    }
}

extension MoviesCollectionViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // FIXME: Search after enter
        MovieClient.fetchMovies(searchQuery: searchBar.text!, completion: {moviesData, error in
            self.userDefault.set(searchBar.text! , forKey: "search")
            guard let moviesData = moviesData, error == nil else {
                print(error ?? NSError())
                return
            }
                                    
            DataManager.sharedInstance.refreshMovieData(moviesData.results)
            /// Update the collection view based on the current state of the `data` property
            var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
            snapshot.appendSections([0])
            snapshot.appendItems(DataManager.sharedInstance.movies)
                                    
            self.dataSource.apply(snapshot)
        })
    }
}

//
// MARK: - Collection View Setup
//

private extension MoviesCollectionViewController {
    
    //FIXME: Update the layout as you see fit to make it look "good"
    func makeLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
                                                                                 heightDimension: NSCollectionLayoutDimension.absolute(200)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),  heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            return section
        }
    }

}
