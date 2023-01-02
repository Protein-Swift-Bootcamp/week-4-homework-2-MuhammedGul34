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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.layer.cornerRadius = 24

        title = "Photo Detail"
       
        // Singelton method for fetching images
        
        NetworkManager.shared.fetchImages(with: photo?.urlZ) { data in
            self.imageView.image = UIImage(data: data)
        }
        NetworkManager.shared.fetchImages(with: photo?.buddyIconUrl) { data in
            self.userImageView.image = UIImage(data: data)
        }
        
        userNameLabel.text = photo?.ownername
        
        if photo?.welcomeDescription?.content?.count ?? 0 > 1 {
            userDescriptionLabel.text = photo?.welcomeDescription?.content
        } else {
           setupFont(label: userDescriptionLabel)
        }
       
        titleLabel.text = photo?.title
        
        if let photoID = photo?.id {
            photoIDLabel.text = "Photo ID: \(photoID)"
        }
    }
}

private func setupFont(label: UILabel){
    label.font = .boldSystemFont(ofSize: 24)
    label.textAlignment = .center
    label.textColor = .red
    label.text = "There is no description for this Photo."
}
