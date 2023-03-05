//
//  ImageListWorker.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation

/// This is used to get the Image List
class ImagesListWorker {

    let netWorkManager: NetworkManager

    init(netWorkManager: NetworkManager) {
        self.netWorkManager = netWorkManager
    }

    /// This is used to get the Images List
    func getImagesList(_ pageId: String, completion: @escaping(([ImageModel], Error?) -> Void)) {
        netWorkManager.getImagesList(pageId, completion: { result in
            switch result {
            case .success(let imagesList):
                completion(imagesList, nil)
            case.failure(let error):
                completion([], error)
            }
        })
    }
}
