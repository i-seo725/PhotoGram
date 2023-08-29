//
//  ViewController.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/28.
//

import UIKit
//import SnapKit

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
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
    }

    @objc func searchButtonClicked() {
        let word = ["Apple", "Banana", "chicken", "Cake", "Blue"]
        NotificationCenter.default.post(name: NSNotification.Name("RecommendKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        
        present(SearchViewController(), animated: true)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print("옵저버 실행")
        print(notification.userInfo?["name"])  // 키값이 any 타입이라 타입캐스팅 필요
        print(notification.userInfo?["sample"])
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoIamageView.image = UIImage(systemName: name)
        }
        
    }
    
    override func configureView() {
        super.configureView()
        print("AddView Configure")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        print("AddView Constraints")
    }

}

