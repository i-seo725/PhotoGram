//
//  TextViewController.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/29.
//

import UIKit

class TextViewController: BaseViewController {
    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var textCompletionHandler: ((String) -> Void)?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        textCompletionHandler?(textView.text!)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
    }
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(150)
        }
    }
}
