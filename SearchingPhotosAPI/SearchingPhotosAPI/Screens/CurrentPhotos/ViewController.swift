//
//  CurrentPhotosViewController.swift
//  SearchingPhotosAPI
//
//  Created by Muhammed Gül on 28.12.2022.
//

import UIKit

class CurrentPhotosTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "RecentPhotoCustomCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RecentPhotoCustomCell
        cell.userProfileImage.image = UIImage(named: "profile")
        cell.RecentPhotoImage.image = UIImage(named: "profile")
        cell.userNameLabel.text = "Muhammed Gül"
        cell.userCommentLabel.text = "A good picture of myself"
        return cell
    }
}





