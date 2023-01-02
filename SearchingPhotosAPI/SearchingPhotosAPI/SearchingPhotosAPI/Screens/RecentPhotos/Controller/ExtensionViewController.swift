//
//  ExtensionViewController.swift
//  SearchingPhotosAPI
//
//  Created by Muhammed Gül on 2.01.2023.
//

import UIKit

extension RecentPhotosTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.photos?.photo.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photo = response?.photos?.photo[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecentPhotoCustomCell
        NetworkManager.shared.fetchImages(with: photo?.urlN) { data in
            cell.RecentPhotoImage.image = UIImage(data: data)
        }
       
        NetworkManager.shared.fetchImages(with: photo?.buddyIconUrl) { data in
            cell.userProfileImage.image = UIImage(data: data)
        }
        
        cell.userNameLabel.text = photo?.ownername
        cell.titleLabel.text = photo?.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPhoto = response?.photos?.photo[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhotoDetail") as! PhotoDetailViewController
        
        let navController = UINavigationController(rootViewController: vc)
        
        vc.photo = selectedPhoto
        
        self.present(navController, animated: true, completion: nil)
    }
}

