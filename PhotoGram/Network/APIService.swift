//
//  APIService.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/30.
//

import Foundation

class APIService {
    
    private init() { }
    static let shared = APIService()    //인스턴스 접근을 shared를 통해서만 가능하게 하겠다
    
    func callRequest() {
        guard let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            //data가 254byte로 나오니까 jSON으로 볼 수 있게 하는 코드
            let value = String(data: data!, encoding: .utf8)
//            print(value)
//            print(data, response, error, separator: "\n")
        }.resume()
    }
}

