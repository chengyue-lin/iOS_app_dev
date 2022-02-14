//
//  FavoritesViewController.swift
//  My Kind of Town
//
//  Created by Ian on 2022/2/13.
//
import Foundation
import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var favPlaces: [String] = []
    weak var delegate: PlacesFavoritesDelegate?
    @IBOutlet var tableView: UITableView!
    
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        favPlaces = DataManager.sharedInstance.listFavorites()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPlaces.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritePlace", for: indexPath)
        cell.textLabel?.text = favPlaces[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(favPlaces[indexPath.row])
        delegate?.favoritePlace(name: favPlaces[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
