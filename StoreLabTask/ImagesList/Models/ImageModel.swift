//
//  ImageModel.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 06/01/23.
//

import Foundation

/// This Class used for ImageModel
class ImageModel: Decodable {
    /// This is unique for each Image
    var imageId: String?
    /// This is used for the author if the Image
    var author: String?
    var url: String?
    /// This is used to download the Image
    var downloadUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case imageId = "id"
        case author
        case url
        case downloadUrl = "download_url"
    }
  
    /// Adding intializer to Intialize Image Model
    init(imageId: String? = nil, author: String? = nil, url: String? = nil, downloadUrl: String? = nil) {
        self.imageId = imageId
        self.author = author
        self.url = url
        self.downloadUrl = downloadUrl
    }
}
