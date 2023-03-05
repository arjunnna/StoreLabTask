//
//  ImageListViewModel.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation

/// This Class is used to handle the business logic for ImageListVC
class ImageListViewModel {
    
    var imagesList: [ImageModel] = []
    
    /// Update the ImagesList
    func updateImagesList(_ imageList: [ImageModel]) {
        self.imagesList.append(contentsOf: imageList)
    }
    
    /// To Get number of sections in ImagesListViewController
    /// - Returns: returns Number of Sections
    func numberOfSections() -> Int {
        return 1
    }
    
    /// To Get number of Rows in ImagesListViewController
    /// - Returns: returns Number of Row
    func numberOfRows() -> Int {
        return self.imagesList.count
    }
    
    func getImageModel(_ indexPath: Int) -> ImageModel {
        return self.imagesList[indexPath]
    }

    /// This Method is used to return the Downloadable url
    /// NOTE: By default response model is giving very high Resoluation(Dimention) images so I am returing the low resolution(Dimention) to download the image faster for better user experience with the specifc imageId
    func getImageUrl(_ indexPath: Int) -> URL? {
        if let _ = self.imagesList[indexPath].downloadUrl,
           let imageId = self.imagesList[indexPath].imageId,
           let url = URL(string: "\(PaciSumApiBaseUrl.baseUrl.rawValue)id/\(imageId)/200/300") {
            return url
        }
        return nil
    }
}
