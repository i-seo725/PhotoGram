//
//  UnsplashNetworkManager.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/31.
//

import Foundation
import Alamofire
import SwiftyJSON

class UnsplashNetworkManager {
    static let shared = UnsplashNetworkManager()
    private init() { }
    
    private let header: HTTPHeaders = ["Authorization": APIKey.unsplash]
    
//    func callRequest(keyword: String, completionHandler: @escaping (ImageCodable) -> Void) {
//        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(keyword)") else { return }
//        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: ImageCodable.self) { response in
//            switch response.result {
//            case .success(let value): completionHandler(value)
//            case .failure(let error): print(error)
//            }
//        }
//    }
    
    func callRequest(keyword: String, completionHandler: @escaping (JSON) -> Void) {
        if let url = URL(string: "https://api.unsplash.com/search/photos?query=\(keyword)") {
            AF.request(url, method: .get, headers: header).validate(statusCode: 100...600).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    }
    
}
