//
//  UIImageExtension.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/8/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import UIKit

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    public static func blank() -> UIImage {
        return UIImage(color: UIColor.clear)!
    }
}