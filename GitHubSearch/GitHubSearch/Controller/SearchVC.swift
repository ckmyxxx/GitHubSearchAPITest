//
//  SearchVC.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/4.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var collectionViewFlow: UICollectionViewFlowLayout!
    
    var items: [Items] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var page = "1"
    
    var isFetching = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // paging
    }
    
    func request(_ user: String,_ page: String) {
        
        isFetching = true
        
        HTTPManager.shared.request(
        GHSearchRequest.searchUser(user, page))
        { [weak self] (result) in
            switch result {
            case .success(let userModel):
                self?.items = [userModel.items]
                self?.isFetching = false
            case .failure:
                self?.items = []
                self?.isFetching = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ResultCollectionViewCell.self), for: indexPath) as? ResultCollectionViewCell else {
            fatalError()
        }
        
        cell.commonInit(image: items[indexPath.row].avatarUrl, account: items[indexPath.row].login)
        
        
        return cell
    }
    
    @IBAction func SearchBtnPressed(_ sender: UIButton) {
        
        if let str = textField.text, isFetching == false {
            
            request(str, page)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSetup()
        
    }
    
    func collectionViewSetup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.yh_registerCellFromNib(String(describing: ResultCollectionViewCell.self))
    }
    
}

