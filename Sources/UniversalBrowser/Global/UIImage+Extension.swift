//
//  File.swift
//  
//
//  Created by BJIT on 29/11/23.
//
import UIKit
extension UIImage {
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage
            let bounds = CGRect(origin: .zero, size: size)

            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { context in
                let cgContext = context.cgContext
                cgContext.clip(to: bounds, mask: maskImage!)
                color.setFill()
                cgContext.fill(bounds)
            }
    }

}
