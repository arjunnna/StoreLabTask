//
//  ImagesListInteractor.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation

protocol ImagesListInteractorInput {
  func getImagesList(_ pageId: String)
}
 
protocol ImagesListInteractorOutput {
    func presentImagesList(_ imagesList: [ImageModel], error: Error?)
}


extension ImagesListInteractor: ImagesListViewControllerOutput {
    
}

/// This is used to Interact with worker and get the ImagesList
class ImagesListInteractor: ImagesListInteractorInput {

    var output: ImagesListInteractorOutput?
    var worker: ImagesListWorker?
    
    // MARK: Business logic

    func getImagesList(_ pageId: String) {
        worker = ImagesListWorker(netWorkManager: NetworkManager())
        worker?.getImagesList(pageId) { [weak self] (imagesList, error) in
            self?.output?.presentImagesList(imagesList, error: error)
        }
    }
}
