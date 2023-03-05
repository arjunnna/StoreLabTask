//
//  ImagesListAPITests.swift
//  StoreLabTaskTests
//
//  Created by Mallikarjuna on 05/03/2023.
//

import XCTest
import Moya
@testable import StoreLabTask

class ImagesListAPITests: XCTestCase {

    var provider: MoyaProvider<ImagesListAPI>!

    var errorProvider: MoyaProvider<ImagesListAPI>!


    let imagesListWorker = ImagesListWorker(netWorkManager: NetworkManager())
    
    var imagesListViewModel = ImageListViewModel()

    
    override func setUp() {
        super.setUp()
        // A mock provider with a mocking `endpointClosure` that stub immediately
        provider = MoyaProvider<ImagesListAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        errorProvider = MoyaProvider<ImagesListAPI>(endpointClosure: errorEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }

    func customEndpointClosure(_ target: ImagesListAPI) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }

    func errorEndpointClosure(_ target: ImagesListAPI) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkError(NSError(domain: "Error", code: 1001)) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    func testImagesListWorker() {
        imagesListWorker.netWorkManager.provider = MoyaProvider<ImagesListAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        imagesListWorker.getImagesList("0") { (imagesList, error) in
            XCTestCase().isEqual( imagesList.count == 20)
        }
    }

    func testImagesListWorkerError() {
        imagesListWorker.netWorkManager.provider = MoyaProvider<ImagesListAPI>(endpointClosure: errorEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        imagesListWorker.getImagesList("0") { (imagesList, error) in
            XCTestCase().isEqual( imagesList.count == 0)
        }
    }


    func testImageListViewModel() {
        imagesListWorker.netWorkManager.provider = MoyaProvider<ImagesListAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        imagesListWorker.getImagesList("0") { (imagesList, error) in
            XCTestCase().isEqual( imagesList.count == 20)
            self.imagesListViewModel.updateImagesList(imagesList)
            XCTestCase().isEqual(self.imagesListViewModel.numberOfRows() == 20)
            XCTestCase().isEqual(self.imagesListViewModel.numberOfSections() == 1)
            XCTestCase().isEqual(self.imagesListViewModel.getImageUrl(0) == URL(string: "https://picsum.photos/id/20/200/300"))
            XCTAssertEqual(imagesList[0].imageId, self.imagesListViewModel.getImageModel(0).imageId)
            XCTAssertNil(self.imagesListViewModel.getImageUrl(19))
            XCTAssertNil(self.imagesListViewModel.getImageUrl(3))
        }
    }
}
