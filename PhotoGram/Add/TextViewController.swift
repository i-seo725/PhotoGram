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
    
    let sampleView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    let sampleView2 = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    var textCompletionHandler: ((String) -> Void)?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        textCompletionHandler?(textView.text!)
    }
    
    func setAnimation() {
        //시작 ui 정의
        sampleView.alpha = 0
        sampleView2.alpha = 0
        
        //끝날 때 ui 정의
        UIView.animate(withDuration: 1, delay: 2, options: .curveLinear) {
            self.sampleView.alpha = 1
            self.sampleView.backgroundColor = .systemYellow
        } completion: { bool in
            
            UIView.animate(withDuration: 1) {
                self.sampleView2.alpha = 1
            }
            
        }

        
    }
    
    
    
    deinit {
        print(self, "deinit")
    }
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
        view.addSubview(sampleView)
        view.addSubview(sampleView2)
        setAnimation()
    }
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(150)
        }
        
        sampleView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        sampleView2.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view).offset(80)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //ui 업데이트에 관한 코드여서 main으로 보냄
        DispatchQueue.main.async {
            self.sampleView2.alpha = 1.0
            UIView.animate(withDuration: 0.3) {
                self.sampleView2.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.sampleView2.alpha = 0.5
            UIView.animate(withDuration: 0.3) {
                self.sampleView2.alpha = 1.0
            }
        }
    }
    
    
}
