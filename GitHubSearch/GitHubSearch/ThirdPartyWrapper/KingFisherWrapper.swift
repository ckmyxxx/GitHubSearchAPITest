//
//  KingFisherWrapper.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/4.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func loadImage(
        _ urlString: String,
        placeHolder: UIImage? = UIImage.asset(ImageAsset.imagePlaceHolder))
    {
        
        let url = URL(string: urlString)
        
        self.kf.setImage(
            with: url,
            placeholder: placeHolder,
            options: [.scaleFactor(UIScreen.main.scale), .transition(.fade(0.2))])
    }
}
