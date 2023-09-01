//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by 이은서 on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    let imageList = ["pencil", "star", "person", "star.fill", "xmark", "person.circle"]
    var completionHandler: ((String) -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    deinit {
        print(self, "deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(recommendKeywordNotificationObserver(notification:)), name: NSNotification.Name("RecommendKeyword"), object: nil)
        
        //searchBar 보일 때 바로 키보드 뜸
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
    }
    
    @objc func recommendKeywordNotificationObserver(notification: NSNotification) {
        print("recommend keyword")
    }
    
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    var delegate: PassImageDataDelegate?
    
    
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(imageList[indexPath.item])
        
//        NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "은서"])
        delegate?.receiveImage(image: UIImage(systemName: imageList[indexPath.item])!)
        
        dismiss(animated: true)
        
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = mainView.searchBar.text {
            UnsplashNetworkManager.shared.callRequest(keyword: mainView.searchBar.text!) { json in
                self.completionHandler?(json["results"][0]["urls"]["raw"].stringValue)
                self.navigationController?.popViewController(animated: true)
            }
        }
        mainView.searchBar.resignFirstResponder()   //키보드 내리기
        
    }
}
