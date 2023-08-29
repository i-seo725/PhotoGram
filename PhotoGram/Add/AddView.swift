//
//  AddView.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/28.
//

import UIKit

class Addview: BaseView {
    
    let photoIamageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    
    override func configureView() {
        addSubview(photoIamageView)
        addSubview(searchButton)
    }
    
    override func setConstraints() {
        photoIamageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoIamageView)
        }
    }
}
