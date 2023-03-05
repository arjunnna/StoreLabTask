//
//  ImageDetailViewModelTests.swift
//  StoreLabTaskTests
//
//  Created by Mallikarjuna on 05/03/2023.
//

import XCTest
@testable import StoreLabTask

class ImageDetailViewModelTests: XCTestCase {

    let imageDetails = ImageDetailsViewModel()

    override func setUp() {
        super.setUp()
    }

    func testImageDetailViewModel() {
        let imageModel = ImageModel(imageId: "10", author: "Test Author", url: "Test Url", downloadUrl: "https://picsum.photos/id/20/200/300")
        imageDetails.addImageToFavoriteList(imageModel, completion: { _ in
            imageDetails.imageModel = imageModel
            XCTestCase().isEqual(self.imageDetails.getImageId() == "10")
            XCTestCase().isEqual(self.imageDetails.getImageTitle() == "Test Author")
            XCTestCase().isEqual(self.imageDetails.getImageUrl() == URL(string: "https://picsum.photos/id/20/200/300"))
            XCTestCase().isEqual(self.imageDetails.getAddToFavouriteTitle() == "Remove From Favourites")
            imageDetails.removeImageFromFavoritesList(imageId: "10", completion: {_ in})
            XCTestCase().isEqual(self.imageDetails.getAddToFavouriteTitle() == "Add to Favourites")
        })
    }

    func testImageDetailViewModelNilValues() {
        self.imageDetails.imageModel = nil
        XCTAssertNil(self.imageDetails.getImageId())
        XCTAssertNil(self.imageDetails.getImageTitle())
        XCTAssertNil(self.imageDetails.getImageUrl())
        self.imageDetails.appDelegate = nil
        XCTestCase().isEqual(self.imageDetails.isAlreadyAdded(imageId: "1000") == false)
        XCTestCase().isEqual(self.imageDetails.getAddToFavouriteTitle() == "Add to Favourites")
        self.imageDetails.removeImageFromFavoritesList(imageId: "10") { isSuccess in
            XCTestCase().isEqual(isSuccess == false)
        }
        self.imageDetails.addImageToFavoriteList(ImageModel()) { isSuccess in
            XCTestCase().isEqual(isSuccess == false)
        }
    }
}
