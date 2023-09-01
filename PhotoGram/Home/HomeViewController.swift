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
        
    var list = Photo(total: 0, total_pages: 0, results: [])
    
    let mainView = HomeView()
    
    override func loadView() {
//        let view = HomeView()   //RC +1
        self.view = mainView
        mainView.delegate = self //RC +1, 이거 있으면 deinit이 안됨 -> homeView에서 delegate 앞에 weak 붙여서 해결
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        APIService.shared.callRequest(query: "space") { photo in
    
            guard let photo else {
                print("ALERT ERROR")
                return
            }
            print("API END")
            self.list = photo
            self.mainView.collectionView.reloadData()
        }
    }
    
    deinit { print(self, #function) }
    
}

extension HomeViewController: HomeViewProtocol {
    
    func didSelectItemAt(indexPath: IndexPath) {
        print(self, indexPath)
        navigationController?.popViewController(animated: true)
    }
    
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        let thumb = list.results[indexPath.item].urls.thumb
        
        //링크 기반으로 이미지 보여주는 것도 네트워크 통신
        guard let url = URL(string: thumb) else {
            cell.imageView.backgroundColor = .systemYellow
            return UICollectionViewCell()
        }
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
//        delegate?.didSelectItemAt(indexPath: indexPath)
        
    }
    
}
