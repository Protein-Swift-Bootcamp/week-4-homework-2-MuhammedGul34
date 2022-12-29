//
//  PhotoDetailViewController.swift
//  SearchingPhotosAPI
//
//  Created by Muhammed Gül on 28.12.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photo: Photo?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.layer.cornerRadius = 24
        
        title = "Photo Detail"
        imageView.backgroundColor = .darkGray
        userImageView.backgroundColor = .darkGray
        userNameLabel.text = "Muhammed Gül"
        userDescriptionLabel.text = "sadasdasdasdsadasdasdasdasdasdasdsadasdasdasdsadasdasdsadasdasdasdasdsad"
      
        NetworkManager.shared.fetchImages(with: photo?.urlZ) { data in
            self.imageView.image = UIImage(data: data)
        }
        NetworkManager.shared.fetchImages(with: photo?.buddyIconUrl) { data in
            self.userImageView.image = UIImage(data: data)
        }
        
        userNameLabel.text = photo?.ownername
        title = photo?.title
        
        userDescriptionLabel.text = photo?.welcomeDescription?.content
    }
}
