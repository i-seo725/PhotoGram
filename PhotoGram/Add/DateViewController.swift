//
//  DateViewController.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    //protocol 값 전달 2.
    //구현은 addVC에서 하지만 값은 DateVC이 갖고 있기
    var delegate: PassDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    //protocol 값 전달 3. 시점 정하기
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.receiveDate(date: mainView.picker.date)
    }
    
    
}
