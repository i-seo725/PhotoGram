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
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.unsplashKey)") else {
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: 5)
        
        //글로벌 쓰레드에서 동작
        URLSession.shared.dataTask(with: request) { data, response, error in
            //해당 구문이 반복 작성되지 않도록 내부에 구현
            DispatchQueue.main.async {
                if let error {
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    completionHandler(nil)    // 데이터가 안 왔을 때에도 nil값을 매개변수로 전달해야함
                    return
                }
                
                guard let data else {
                    completionHandler(nil)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    print(result)
                } catch {
                    print(error)    //디코딩 오류 키 알 수 있음
                }
            }
            
           
            
            //data가 254byte로 나오니까 jSON으로 볼 수 있게 하는 코드
//            let value = String(data: data!, encoding: .utf8)
//            print(value)
//            print(data, response, error, separator: "\n")
        }.resume()
    }
} 

struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
