//
//  OptionsView.swift
//
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 8/11/23.
//

import UIKit

class OptionsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    func viewInit(){
        let xibView = Bundle.module.loadNibNamed("OptionView", owner: self)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
        isHidden(true)
    }
    
    func isHidden(_ isHidden: Bool){
        if (isHidden){
            self.isHidden = true
        }
        else{
            self.isHidden = false
        }
        
    }
    
    
}




