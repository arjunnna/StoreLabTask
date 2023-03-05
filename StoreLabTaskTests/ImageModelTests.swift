//
//  ImageModelTests.swift
//  StoreLabTaskTests
//
//  Created by Mallikarjuna on 05/03/2023.
//

import XCTest
@testable import StoreLabTask

final class ImageModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    /// This is used to Test ImadeModel Decode
    func testImageModelDecode() {
        if let path = Bundle.main.path(forResource: "ImagesList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let imagesList = try JSONDecoder().decode([ImageModel].self, from: data)
                XCTestCase().isEqual( imagesList.count == 20)
                XCTestCase().isEqual(imagesList[0].imageId == "20")
                XCTestCase().isEqual(imagesList[0].author == "Aleks Dorohovich")
            } catch {
                // handle error
            }
        }
    }

    /// This is used to Test ImadeModel Decode
    func testImageModelIntialization() {
        let imageModel = ImageModel(imageId: "10", author: "Test Author")
        XCTestCase().isEqual(imageModel.imageId == "10")
        XCTestCase().isEqual(imageModel.author == "Test Author")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
