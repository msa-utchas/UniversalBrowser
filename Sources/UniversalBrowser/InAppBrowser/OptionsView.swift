//
//  OptionsView.swift
//
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 8/11/23.
//

import UIKit

class OptionsView: UIView {
    
    @IBOutlet weak var backView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    @IBOutlet weak var btnHistory: UIButton!{
        didSet{
            btnHistory.addTarget(self, action: #selector(ShowHistory), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnBookmark: UIButton!{
        didSet{
            btnBookmark.addTarget(self, action: #selector(ShowBookMark), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnShare: UIButton!{
        didSet{
            btnShare.addTarget(self, action: #selector(ShareLink), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnOIB: UIButton!{
        didSet{
            btnOIB.addTarget(self, action: #selector(openInBrowser), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnBookMark: UIButton!{
        didSet{
            btnBookMark.addTarget(self, action: #selector(setBookmark), for: .touchUpInside)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    func viewInit(){
        let xibView = Bundle.module.loadNibNamed("OptionView", owner: self)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
        
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

extension OptionsView{
    @objc private func ShowHistory(){
       
    }
    @objc private func ShowBookMark(){
        
    }
    @objc private func ShareLink(){
  
    }
    @objc private func openInBrowser(){

    }
    @objc private func setBookmark(){
        
    }
}


