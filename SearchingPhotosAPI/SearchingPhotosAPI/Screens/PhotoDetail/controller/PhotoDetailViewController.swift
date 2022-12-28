//
//  PhotoDetailViewController.swift
//  SearchingPhotosAPI
//
//  Created by Muhammed Gül on 28.12.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userCommentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Photo Detail"
        imageView.backgroundColor = .darkGray
        userImageView.backgroundColor = .darkGray
        userNameLabel.text = "Muhammed Gül"
        userCommentLabel.text = "sadasdasdasdsadasdasdasdasdasdasdsadasdasdasdsadasdasdsadasdasdasdasdsad"
        
    }
}
