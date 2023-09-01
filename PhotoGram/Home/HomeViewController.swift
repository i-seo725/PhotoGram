//
//  HomeViewController.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/31.
//

import UIKit

//AnyObject: 클래스에서만 프로토콜을 채택할 수 있게 제약
protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
        
    override func loadView() {
        let view = HomeView()   //RC +1
        self.view = view
        view.delegate = self //RC +1, 이거 있으면 deinit이 안됨 -> homeView에서 delegate 앞에 weak 붙여서 해결
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
    }
    
    deinit { print(self, #function) }
    
}

extension HomeViewController: HomeViewProtocol {
    
    func didSelectItemAt(indexPath: IndexPath) {
        print(self, indexPath)
        navigationController?.popViewController(animated: true)
    }
    
}
