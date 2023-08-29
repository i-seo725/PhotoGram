//
//  BaseCollectionViewCell.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/28.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { }
    func setContraints() { }
}
