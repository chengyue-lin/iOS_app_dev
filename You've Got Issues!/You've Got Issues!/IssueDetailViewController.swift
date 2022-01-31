//
//  IssueDetailViewController.swift
//  You've Got Issues!
//
//  Created by Ian on 2022/1/29.
//

import UIKit

class IssueDetailViewController: UIViewController {
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var detailPosterName: UILabel!
    @IBOutlet var detailDate: UILabel!
    @IBOutlet var detailBody: UITextView!
    @IBOutlet var detailImage: UIImageView!
    
    var data: GithubIssue?
    var color: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if color == "red"{
            let bar = UINavigationBarAppearance()
            bar.backgroundColor = .systemRed
            navigationItem.standardAppearance = bar
            navigationItem.scrollEdgeAppearance = bar
        }else{
            let bar = UINavigationBarAppearance()
            bar.backgroundColor = .systemGreen
            navigationItem.standardAppearance = bar
            navigationItem.scrollEdgeAppearance = bar
        }
        
        let format = DateFormatter()
        format.dateStyle = .long
        format.timeStyle = .none
        let date = Date(timeIntervalSinceReferenceDate: 118800)
        
        
        detailDate.text = "Date: " + format.string(from: date)
        
        detailTitle.text = data?.title
        
        detailPosterName.text = "Author: " + String("@") + (data?.user.login)!
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        detailBody.text = data?.body
        
        if data?.state == "open"{
            detailImage.image = UIImage(systemName: "tray.fill")
        }else{
            detailImage.image = UIImage(systemName: "xmark.bin.fill")
        }
        
        
        

        // Do any additional setup after loading the view.
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
