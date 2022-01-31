//
//  OpenIssueViewController.swift
//  You've Got Issues!
//
//  Created by Ian on 2022/1/29.
//

import UIKit

class OpenIssueViewController: UITableViewController {
    
    var source = [GithubIssue]()
    var strcolor1 = "red"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bar = UINavigationBarAppearance()
        bar.backgroundColor = .systemRed
        navigationItem.standardAppearance = bar
        navigationItem.scrollEdgeAppearance = bar
        
        
        GitHubClient.fetchIssues(state:"open", completion: {(issues, error) in
          
        // Ensure we have good data before anything else
            guard let issues = issues, error == nil else {
                print(error!)
                return
            }
            
            for issue in issues {
                self.source.append(issue)
            }
            self.tableView.reloadData()
        })
        
        let refreshControl = UIRefreshControl()
        let title = NSAttributedString(string: "Refreshing...")
        refreshControl.attributedTitle = title
        refreshControl.addTarget(self,
                                 action: #selector(refresh(sender:)),
                                 for: .valueChanged)
        self.tableView.refreshControl = refreshControl

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func refresh(sender: UIRefreshControl) {
        print("done refreshing")
        sender.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.source.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "openIssue", for: indexPath) as! IssuesTableViewCell
        cell.openTitle.text = self.source[indexPath.row].title
        cell.openUserName.text = String("@") + self.source[indexPath.row].user.login
        

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let detailPage = segue.destination as! IssueDetailViewController
        let row = self.tableView!.indexPathForSelectedRow!.row
        detailPage.data = self.source[row]
        detailPage.color = self.strcolor1
    }
    

}
