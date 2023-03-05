//
//  BaseTarget.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation
import Moya

enum PaciSumApiBaseUrl: String {
    case baseUrl = "https://picsum.photos/"
}

/// This is used to fetch the Images List
enum ImagesListAPI {
    case imagesList(pageId: String)
}

extension ImagesListAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: PaciSumApiBaseUrl.baseUrl.rawValue) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .imagesList:
            return "v2/list"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .imagesList(let pageId):
            return .requestParameters(parameters: ["limit":"10", "page": pageId], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}


extension ImagesListAPI {
    var testSampleData: Data {
        switch self {
        case .imagesList:
            if let path = Bundle.main.path(forResource: "ImagesList", ofType: "json") {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                   return data
                }
            }
            return Data()
        }
    }
}
