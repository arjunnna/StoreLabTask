//
//  ImagesListPresenter.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation

protocol ImagesListPresenterInput {
    func presentImagesList(_ imagesList: [ImageModel], error: Error?)
}

protocol ImagesListPresenterOutput: AnyObject {
    func showImagesLists(_ imagesList: [ImageModel], error: Error?)
}

extension ImagesListPresenter: ImagesListInteractorOutput {

}

/// This is used to Preset the ImageList to ImageListVc
class ImagesListPresenter: ImagesListPresenterInput {

    weak var output: ImagesListViewController?

    // MARK: Presentation logic

    func presentImagesList(_ imagesList: [ImageModel], error: Error?) {
        output?.showImagesLists(imagesList, error: error)
    }
}
