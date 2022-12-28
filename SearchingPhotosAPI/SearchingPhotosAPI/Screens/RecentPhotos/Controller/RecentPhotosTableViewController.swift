//
//  CurrentPhotosViewController.swift
//  SearchingPhotosAPI
//
//  Created by Muhammed Gül on 28.12.2022.
//

import UIKit

class RecentPhotosTableViewController: UITableViewController, UISearchResultsUpdating {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type here to search"
        navigationItem.searchController = search
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecentPhotoCustomCell
        cell.userProfileImage.image = UIImage(named: "profile")
        cell.RecentPhotoImage.image = UIImage(named: "profile")
        cell.userNameLabel.text = "Muhammed Gül"
        cell.userCommentLabel.text = "A good picture of myself"
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "toDetailPhotoVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PhotoDetailViewController {
            //TODO: sending details of photo selected
        }
    }
    // MARK: UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 2 {
            print(text)
        }
    }
}





