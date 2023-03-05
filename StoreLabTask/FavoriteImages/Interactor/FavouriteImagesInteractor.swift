//
//  FavouriteImagesInteractor.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation
protocol FavouriteImagesInteractorInput {
  func getFavouriteImagesList()
}
 
protocol FavouriteImagesInteractorOutput {
    func presentFavouriteImagesList(_ imagesList: [FavouriteImages], error: Error?)
}


extension FavouriteImagesInteractor: FavouriteImagesViewControllerOutput {

}

/// This is used to Interact with worker and get the ImagesList
class FavouriteImagesInteractor: FavouriteImagesInteractorInput {

    var output: FavouriteImagesInteractorOutput?
    var worker: FavouriteImagesWorker?
    
    // MARK: Business logic
    func getFavouriteImagesList() {
        worker = FavouriteImagesWorker()
        worker?.getFavouriteImagesList{ [weak self] (imagesList, error) in
            self?.output?.presentFavouriteImagesList(imagesList, error: error)
        }
    }
}
