//
//  ViewController.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/28.
//

import UIKit
import SeSACPhotoFramework
//import SnapKit

//delegate 패턴을 활용한 값 전달 1단계, 프로토콜로 형태 만들기
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol PassImageDataDelegate {
    func receiveImage(image: UIImage)
}


class AddViewController: BaseViewController {

    let mainView = Addview()
    
    //viewDidLoad보다 먼저 호출됨, 뷰 구성하는 메서드, 이 시점에 루트뷰 관련 요소 생성
    //super 메서드 호출하면 안됨
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //첫번째 매개변수: 누가 처리할 것인지?
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
        
        ClassOpenExample.publicExample()
        ClassPublicExample.publicExample()
        sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
//        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }
    

    @objc func searchButtonClicked() {
        let word = ["Apple", "Banana", "chicken", "Cake", "Blue"]
        NotificationCenter.default.post(name: NSNotification.Name("RecommendKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
    
//        print(notification.userInfo?["name"])  // 키값이 any 타입이라 타입캐스팅 필요
//        print(notification.userInfo?["sample"])
        print(#function)
        //한번만 등록되지 않고 여러번 등록되기 때문에 여러번 실행될 수 있음 -> 이러면 화면 전환이 꽤 느려짐
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoIamageView.image = UIImage(systemName: name)
        }
        
    }
    
    override func configureView() {
        super.configureView()
        print("AddView Configure")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonTapped), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonTapped), for: .touchUpInside)
        mainView.textButton.addTarget(self, action: #selector(textButtonTapped), for: .touchUpInside)
    }
    
    @objc func textButtonTapped() {
        let vc = TextViewController()
        vc.textCompletionHandler = { text in
            self.mainView.textButton.setTitle(text, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonTapped() {
        let vc = TitleViewController()
        
        //closure 값 전달 3단계. 클로저 내용 쓰기
        vc.completionHandler = { title, num, push in
            self.mainView.titleButton.setTitle(title, for: .normal)
            print("Completion Handler 함수", num, push)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonTapped() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func dateButtonClicked() {
        //Protocol 값 전달 5. delegate 연결
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setConstraints() {
        super.setConstraints()
        print("AddView Constraints")
    }

}


//protocol 값 전달 4. 값 받기
extension AddViewController: PassDataDelegate {
    
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

extension AddViewController: PassImageDataDelegate {
    func receiveImage(image: UIImage) {
        mainView.photoIamageView.image = image
    }
}
