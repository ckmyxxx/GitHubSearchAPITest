//
//  ResultCollectionViewCell.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/3.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var accountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func commonInit(image: String, account: String) {
        imageView.loadImage(image)
        accountLabel.text = account
    }

}
