//
//  SearchVC.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/4.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var blankHintLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionViewFlow: UICollectionViewFlowLayout!
    
    var nextPage: Bool? = false
    
    var items: [Items] = [] {
        didSet {
            checkIsHaveContent()
        }
    }
    
    var page = 1
    
    var isFetching = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta = collectionView.contentSize.height - collectionView.contentOffset.y
        
        if  delta < 1500,
            let str = searchBar.text,
            isFetching == false,
            nextPage == true {
            
            page += 1
            
            request(str, String(page))
            
        }
    }
    
    func checkIsHaveContent() {
        if items.count == 0 {
            collectionViewIsHidden(true)
        } else {
            collectionViewIsHidden(false)
        }
    }
    
    func request(_ user: String,_ page: String) {
        
        startLoading()
        
        HTTPManager.shared.request(
        GHSearchRequest.searchUser(user, page))
        { [weak self] (result) in
            switch result {
            case .success(let userModel):
                self?.nextPage = userModel.next
                self?.items.append(contentsOf: userModel.items)
                self?.stopLoading()
                
                DispatchQueue.main.async {
                    self?.errorLabel.text = nil
                }
                
            case .failure(let err):
                
                DispatchQueue.main.async {
                    self?.errorLabel.text = err.localizedDescription
                }
                
                self?.items = []
                self?.stopLoading()
            }
        }
    }
    
    func startLoading() {
        blankHintLabel.hidden(true)
        activeIndicator.startLoad()
        isFetching = true
    }
    
    func stopLoading() {
        blankHintLabel.hidden(false)
        activeIndicator.stopLoad()
        isFetching = false
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ResultCollectionViewCell.self),
            for: indexPath) as? ResultCollectionViewCell else {fatalError()}
        
        cell.commonInit(image: items[indexPath.row].avatarUrl, account: items[indexPath.row].login)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSetup()
        
        checkIsHaveContent()
        
        searchBar.delegate = self
        
    }
    
    func collectionViewSetup() {
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        collectionView.yh_registerCellFromNib(String(describing: ResultCollectionViewCell.self))
        
        collectionViewFlow.itemSize = CGSize(width: CGFloat(UIScreen.width / 2 - 20), height: CGFloat(UIScreen.width / 2 - 20) * 4 / 3)
        
        collectionViewFlow.scrollDirection = .vertical
        
    }
    
    func reloadData() {
        
        guard Thread.isMainThread == true else {
            
            DispatchQueue.main.async { [weak self] in
                
                self?.reloadData()
            }
            
            return
        }
        
        collectionView.reloadData()
    }
    
    func collectionViewIsHidden(_ bool: Bool) {
        
        guard Thread.isMainThread == true else {
            
            DispatchQueue.main.async { [weak self] in
                
                self?.collectionViewIsHidden(bool)
            }
            
            return
        }

        collectionView.isHidden = bool
        reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let str = searchBar.text, isFetching == false else { return }
        
        page = 1
        
        items = []
        
        checkIsHaveContent()
        
        request(str, String(page))
    }

    
}
