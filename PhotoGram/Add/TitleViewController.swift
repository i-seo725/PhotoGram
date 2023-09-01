//
//  TitleViewController.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    //closure 값 전달 1단계.
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    @objc func doneButtonClicked() {
        completionHandler?(textField.text!, 725, true)
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //옵셔널 타입으로 옵셔널 체이닝 구문 사용
        //closure 값 전달 2단계. 함수 실행
        completionHandler?(textField.text!, 100, false)
        
    }
    deinit {
        print(self, "deinit")
    }
}
