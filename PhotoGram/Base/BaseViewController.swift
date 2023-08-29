//
//  BaseViewController.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/28.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .white
        print("Base Configure View")
    }
    
    func setConstraints() {
        print("Base Constratints")
    }
}
