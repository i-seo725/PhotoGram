//
//  URLSessionViewController.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController {
    
    var session: URLSession!
    var total: Double = 0
    var buffer: Data? {   // 쪼개서 가져오는 데이터 담기, 버퍼를 둠
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100)%"
        }
    }
    let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .darkGray
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        buffer = Data() //buffer?.append(data)가 실행되기 위해 미리 초기화 해주기
        
        view.backgroundColor = .white
        view.addSubview(progressLabel)
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(250)
        }
        
        guard let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg") else { return }
        
        //환경설정, configuration만 있으면 completionHandler 사용
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main) //main 쓰레드에 async로 동작
        session.dataTask(with: url).resume()
        
        
    }

    //사진 다운로드 중 다른 화면으로 가거나 취소한다면?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //취소 액션(화면이 사라질 때) - 리소스 정리, 실행 중인 것도 무시
        session.invalidateAndCancel()
        
        //여러 개를 받을 때 현재 받고 있던 리소스 다운로드가 끝나면 나머지는 정리
        session.finishTasksAndInvalidate()
        
    }
    
    
}




extension URLSessionViewController: URLSessionDataDelegate {
    
//    서버에서 최초로 응답 받은 경우 호출(상태코드 처리), 헤더값 받기
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("RESPONSE", response)
        
        if let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) {
            
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            
            return .allow
        } else {
            return .cancel
        }
        
    }
    
    //서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA: ", data)
        buffer?.append(data)    //buffer가 nil이면 append 구문 실행 안됨
//        imageView.image = UIImage(data: buffer!)
    }
    
    //서버의 응답이 완료된 이후 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
        
        if let error {
            print(error)
        } else {
            guard let buffer = buffer else {
                print(error)
                return
            }
            imageView.image = UIImage(data: buffer)
        }
        
    }
}
