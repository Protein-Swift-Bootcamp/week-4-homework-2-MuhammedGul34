//
//  CurrentPhotosViewController.swift
//  SearchingPhotosAPI
//
//  Created by Muhammed Gül on 28.12.2022.
//

import UIKit

class RecentPhotosTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var response : PhotoResponse? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var selectedPhoto: Photo?
    
    private func handleProgressBar(){
        progressBar.progress = 0
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (timer) in
            self.progressBar.progress += 0.2
            let deger : Float = self.progressBar.progress
            if deger == 1 {
                timer.invalidate()
                self.progressBar.isHidden = true
            }
        }
    }
    
    private func setupSearchController(){
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type here to search"
        navigationItem.searchController = search
    }
    
    // Fetching datas when we look app in the first page
    private func fetchRequest(){
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=de0b083d4a218ed778abc1dbdc6811e2&format=json&nojsoncallback=1&extras=description,owner_name,icon_server,url_n,url_z") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }
            if let data = data, let response = try? JSONDecoder().decode(PhotoResponse.self, from: data) {
                self.response = response
            }
        }.resume()
    }
    // Fetching data when we search specialized topic
    private func searchPhotos(with text: String){
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=de0b083d4a218ed778abc1dbdc6811e2&text=\(text)&format=json&nojsoncallback=1&extras=description,owner_name,icon_server,url_n,url_z") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }
            if let data = data, let response = try? JSONDecoder().decode(PhotoResponse.self, from: data) {
                self.response = response
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleProgressBar()
        
        fetchRequest()
        setupSearchController()
        
        tableView.delegate = self
        tableView.dataSource = self
      
        self.tableView.register(UINib(nibName: "RecentPhotoCustomCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    // MARK: UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 2 {
            searchPhotos(with: text)
        }
    }
}

