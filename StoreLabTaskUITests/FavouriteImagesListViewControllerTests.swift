//
//  FavouriteImagesListViewControllerTests.swift
//  StoreLabTaskUITests
//
//  Created by Mallikarjuna on 05/03/2023.
//

import XCTest

final class FavouriteImagesListViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testFavouriteImagesListViewController() {
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.staticTexts["Home"].exists)
        app.collectionViews[ImagesListIdentifiers.collectionView.rawValue].cells.element(boundBy:0).tap()
        XCTAssert(app.staticTexts["Image Details"].exists)
        app.buttons[ImageDetailIdentifiers.addToFavouriteButton.rawValue].tap()
        app.buttons[ImageDetailIdentifiers.okButton.rawValue].tap()
        app.buttons[ImageDetailIdentifiers.backButton.rawValue].tap()
        app.tabBars.buttons.element(boundBy: 1).tap()
        XCTAssert(app.staticTexts["Favourites"].exists)
        app.collectionViews[FavouriteImagesIdentifiers.collectionView.rawValue].cells.element(boundBy:0).tap()
        XCTAssert(app.staticTexts["Image Details"].exists)
        app.buttons[ImageDetailIdentifiers.addToFavouriteButton.rawValue].tap()
        app.buttons[ImageDetailIdentifiers.okButton.rawValue].tap()
        XCTAssert(app.staticTexts["Favourites"].exists)
    }


    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
