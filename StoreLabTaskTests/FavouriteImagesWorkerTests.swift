//
//  FavouriteImagesWorkerTests.swift
//  StoreLabTaskTests
//
//  Created by Mallikarjuna on 05/03/2023.
//

import XCTest
@testable import StoreLabTask

class FavouriteImagesWorkerTests: XCTestCase {

    let favouriteImagesWorker = FavouriteImagesWorker()
    let favouriteImageViewModel = FavouriteImagesViewModel()
    let imageDetails = ImageDetailsViewModel()

    override func setUp() {
        super.setUp()
    }

    func testGetFavouriteImages() {
        let imageModel = ImageModel(imageId: "10", author: "Test Author", url: "Test Url", downloadUrl: "https://picsum.photos/id/20/200/300")
        imageDetails.addImageToFavoriteList(imageModel, completion: {_ in
            favouriteImagesWorker.getFavouriteImagesList { imagesList, error in
                XCTestCase().isEqual( imagesList.count == 1)
                self.favouriteImageViewModel.imagesList = imagesList
                XCTestCase().isEqual(self.favouriteImageViewModel.numberOfSections() == 1)
                XCTestCase().isEqual(self.favouriteImageViewModel.numberOfRows() == 1)
                XCTestCase().isEqual(self.favouriteImageViewModel.getImageUrl(0) == URL(string: "https://picsum.photos/id/20/200/300"))
                XCTAssertEqual(imagesList[0].imageId, self.favouriteImageViewModel.getImageModel(0).imageId)
                self.imageDetails.removeImageFromFavoritesList(imageId: "10", completion: {_ in})
            }
        })
       
    }

    func testGetFavouriteImageUrl() {
        let imageModel = ImageModel(imageId: "10", author: "Test Author")
        imageDetails.addImageToFavoriteList(imageModel, completion: {_ in
            favouriteImagesWorker.getFavouriteImagesList { imagesList, error in
                XCTestCase().isEqual( imagesList.count == 1)
                self.favouriteImageViewModel.imagesList = imagesList
                XCTAssertNil(self.favouriteImageViewModel.getImageUrl(0))
                self.imageDetails.removeImageFromFavoritesList(imageId: "10", completion: {_ in})
            }
        })
    }
}
