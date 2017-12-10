//
//  MatchedViewController.swift
//  Dndating
//
//  Created by Sky Xu on 12/10/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class MatchedViewController: UIViewController {

    var matchedUsers: [UserData]?
//    = [] {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
}

extension MatchedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MatchedCell
        let row = indexPath.row
        let eachMatch = matchedUsers![row]
        cell.nameLabel.text = eachMatch.userData.user
        cell.percentageLabel.text = eachMatch.userData.percentage
        let url = URL(string: eachMatch.userData.img)
        let data = try? Data(contentsOf: url!)
        if let data = data {
            let img = UIImage(data: data)
            cell.profileImg.contentMode = .scaleAspectFit
            cell.profileImg.image = img
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedUsers!.count
    }
}
