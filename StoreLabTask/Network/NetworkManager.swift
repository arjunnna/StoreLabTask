//
//  NetworkManager.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<ImagesListAPI> { get }

    /// This Method is used to get the Images List
    func getImagesList(_ pageId: String, completion: @escaping (Result<[ImageModel], Error>) -> ())
}

class NetworkManager: Networkable {

    init() {
    
    }
    
    var provider = MoyaProvider<ImagesListAPI>(plugins: [NetworkLoggerPlugin()])

    /// This Method is used to get the Images List
    func getImagesList(_ pageId: String, completion: @escaping (Result<[ImageModel], Error>) -> ()) {
        request(target: .imagesList(pageId: pageId), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: ImagesListAPI, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                self.parseResponseData(data: response.data, completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func parseResponseData<T: Decodable>(data: Data, completion: (Result<T, Error>) -> ()) {
        do {
            let results = try JSONDecoder().decode(T.self, from: data)
            completion(.success(results))
        } catch let error {
            completion(.failure(error))
        }
    }
}
