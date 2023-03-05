//
//  FavouriteImagesWorker.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation
import CoreData
import UIKit

/// This is used to get the Favourite Image List
class FavouriteImagesWorker {
    
    /// This is used to get the Favourite Images List
    func getFavouriteImagesList(completion: @escaping(([FavouriteImages], Error?) -> Void)) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<FavouriteImages>(entityName: "FavouriteImages")
            do {
                let result = try context.fetch(request)
                completion(Array(result), nil)
            } catch let error {
                completion([], error)
            }
        }
    }
}
