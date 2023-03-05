//
//  FavouritesListPresenter.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation

protocol FavouritesImagesListPresenterInput {
    func presentFavouriteImagesList(_ imagesList: [FavouriteImages], error: Error?)
}

protocol FavouritesImagesListPresenterOutput: AnyObject {
    func showFavouritesImagesLists(_ imagesList: [FavouriteImages], error: Error?)
}

extension FavouritesImagesListPresenter: FavouriteImagesInteractorOutput {

}

/// This is used to Preset the ImageList to ImageListVc
class FavouritesImagesListPresenter: FavouritesImagesListPresenterInput {

    weak var output: FavouriteImagesViewController?

    // MARK: Presentation logic

    func presentFavouriteImagesList(_ imagesList: [FavouriteImages], error: Error?) {
        output?.showFavouritesImagesLists(imagesList, error: error)
    }
}
