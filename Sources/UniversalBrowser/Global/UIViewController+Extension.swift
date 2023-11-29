//
//  File.swift
//  
//
//  Created by BJIT on 29/11/23.
//

import UIKit
extension UIViewController {
    public func getUBViewController(type:UBVCType)->UIViewController{
        return UIStoryboard(name: "UBStoryBoard", bundle: Bundle.module).instantiateViewController(withIdentifier: type.rawValue)
    }
}
