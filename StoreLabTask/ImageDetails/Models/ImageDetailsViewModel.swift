//
//  ImageDetailsViewModel.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation
import CoreData
import UIKit

/// This Class is used to handle the business logic for ImageDetailsViewController
class ImageDetailsViewModel {
        
    var imageModel: ImageModel?

    var appDelegate = (UIApplication.shared.delegate as? AppDelegate)

    /// This Method is used to add Image to FavouritesList
    func addImageToFavoriteList(_ image: ImageModel, completion: (Bool) -> Void) {
        if let context = self.appDelegate?.persistentContainer.viewContext, let entity = NSEntityDescription.entity(forEntityName: "FavouriteImages", in: context) {
            if let newFavouriteImage = NSManagedObject(entity: entity, insertInto: context) as? FavouriteImages {
                newFavouriteImage.author = image.author
                newFavouriteImage.downloadUrl = image.downloadUrl
                newFavouriteImage.imageId = image.imageId
                newFavouriteImage.isFavourite = true
                newFavouriteImage.url = image.url
                do {
                    try context.save()
                    completion(true)
                } catch {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func getImageTitle() -> String? {
        if let imageModel = imageModel {
            return imageModel.author
        }
        return nil
    }
    
    func getImageId() -> String? {
        if let imageModel = imageModel {
            return imageModel.imageId
        }
        return nil
    }

    func getImageUrl() -> URL? {
        if let imageUrl = imageModel?.downloadUrl {
            return URL(string: imageUrl)
        }
        return nil
    }

    func getAddToFavouriteTitle() -> String {
        if let imageId = self.getImageId(),
           self.isAlreadyAdded(imageId: imageId) {
            return "Remove From Favourites"
        }
        return "Add to Favourites"
    }
    
    func isAlreadyAdded(imageId: String) -> Bool {
        if let context = appDelegate?.persistentContainer.viewContext {
            let request = NSFetchRequest<FavouriteImages>(entityName: "FavouriteImages")
            if let result = try? context.fetch(request) {
                return result.filter {$0.imageId == imageId}.count > 0 ? true : false
            }
        }
        return false
    }

    /// This Method is used to remove Image from FavouritesList
    func removeImageFromFavoritesList(imageId: String, completion: (Bool) -> Void) {
        if let context = appDelegate?.persistentContainer.viewContext {
            let request = NSFetchRequest<FavouriteImages>(entityName: "FavouriteImages")
            if let result = try? context.fetch(request) {
                let results = result.filter {$0.imageId == imageId}
                if results.count > 0 {
                    context.delete(results[0])
                    do {
                        try context.save()
                        completion(true)
                    } catch {
                        completion(false)
                    }
                }
            } else {
                completion(false)
            }
        } else {
            completion(false)
        }
    }
}
