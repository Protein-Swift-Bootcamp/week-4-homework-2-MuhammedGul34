//
//  NetworkManager.swift
//  SearchingPhotosAPI
//
//  Created by Muhammed Gül on 30.12.2022.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
     func fetchImages(with url: String?, completion: @escaping (Data) -> Void){
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
}

