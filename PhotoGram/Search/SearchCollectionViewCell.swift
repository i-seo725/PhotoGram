//
//  SearchCollectionViewCell.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/28.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .systemOrange
        view.contentMode = .scaleToFill
        view.tintColor = .white
        return view
    }()
    
    
    override func configureView() {
        contentView.addSubview(imageView)
    }
    
    override func setContraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
