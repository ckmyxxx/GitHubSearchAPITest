//
//  UIImage+EX.swift
//  GitHubSearch
//
//  Created by Huang YenHan on 2019/6/4.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import Foundation
import UIKit

enum ImageAsset: String {
    
    case imagePlaceHolder
    
}

extension UIImage {
    
    static func asset(_ asset: ImageAsset) -> UIImage? {
        
        return UIImage(named: asset.rawValue)
    }
}
