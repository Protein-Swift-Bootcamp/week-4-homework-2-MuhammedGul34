//
//  CurrentPhotosViewController.swift
//  SearchingPhotosAPI
//
//  Created by Muhammed Gül on 28.12.2022.
//

import UIKit

class RecentPhotosTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var response : PhotoResponse? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
    
    private func fetchImages(with url: String?, completion: @escaping (Data) -> Void){
        if let urlString = url, let url = URL(string: urlString){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    debugPrint(error)
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        completion(data)
                    }
                }
            }.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRequest()
        setupSearchController()
        
        tableView.delegate = self
        tableView.dataSource = self
      
        self.tableView.register(UINib(nibName: "RecentPhotoCustomCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.photos?.photo.count ?? 0
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photo = response?.photos?.photo[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecentPhotoCustomCell
        cell.userProfileImage.image = UIImage(named: "profile")
        
        fetchImages(with: photo?.urlN) { data in
            cell.RecentPhotoImage.image = UIImage(data: data)
        }
       
        if let iconserver = photo?.iconserver,
           let iconfarm = photo?.iconfarm,
           let nsid = photo?.owner,
           NSString(string: iconserver).intValue > 0  {
            fetchImages(with: "http://farm\(iconfarm).staticflickr.com/\(iconserver)/buddyicons/\(nsid).jpg") { data in
                cell.userProfileImage.image = UIImage(data: data)
            }
        } else {
                fetchImages(with: "https://www.flickr.com/images/buddyicon.gif") { data in
                    cell.userProfileImage.image = UIImage(data: data)
            }
        }
        
        cell.RecentPhotoImage.backgroundColor = .darkGray
        
        
        cell.userNameLabel.text = photo?.ownername
        cell.titleLabel.text = photo?.title
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
            searchPhotos(with: text)
        }
    }
}





