//
//  Photos.swift
//  SearchingPhotosAPI
//
//  Created by Muhammed Gül on 28.12.2022.
//

import Foundation

struct Photos: Codable {
  let page: Int?
  let pages: Int?
  let perpage: Int?
  let total: Int?
  let photo: [Photo?] 
}
