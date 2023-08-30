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
    
    let searchProtocolButton = {
        let view = UIButton()
        view.backgroundColor = .green
        return view
    }()
    
    let dateButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle(DateFormatter.today(), for: .normal)
        return view
    }()
    
    let titleButton = {
        let view = UIButton()
        view.backgroundColor = .green
        view.setTitle("오늘의 사진", for: .normal)
        return view
    }()
    
    let textButton = {
        let view = UIButton()
        view.backgroundColor = .green
        view.setTitle("텍스트", for: .normal)
        return view
    }()
    
    
    override func configureView() {
        addSubview(photoIamageView)
        addSubview(searchButton)
        addSubview(dateButton)
        addSubview(searchProtocolButton)
        addSubview(titleButton)
        addSubview(textButton)
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
        dateButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(photoIamageView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        searchProtocolButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.leading.equalTo(photoIamageView)
        }
        titleButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(dateButton.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        textButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
    }
}
