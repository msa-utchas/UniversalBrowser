//
//  OptionsView.swift
//
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 8/11/23.
//

import UIKit

@available(iOS 13.0, *)
class OptionsView: UIView {
   
    
    @IBOutlet weak var bookmarkBackView: UIView!{
        didSet{
            bookmarkBackView.layer.cornerRadius = 5
            bookmarkBackView.addShadow()
        }
    }
    @IBOutlet weak var historyBackView: UIView!{
        didSet{
            historyBackView.layer.cornerRadius = 5
            historyBackView.addShadow()
        }
    }
    @IBOutlet weak var shareBackView: UIView!{
        didSet{
            shareBackView.layer.cornerRadius = 5
            shareBackView.addShadow()
        }
    }
    @IBOutlet weak var buttonTV: UITableView!{
        didSet{
            buttonTV.dataSource = self
            buttonTV.delegate = self
            buttonTV.register(UINib(nibName: "ButtonTVCell", bundle: Bundle.module), forCellReuseIdentifier: "ButtonTVCell")
            buttonTV.backgroundColor = .clear
        }
    }
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

@available(iOS 13.0, *)
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


@available(iOS 13.0, *)
extension OptionsView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = buttonTV.dequeueReusableCell(withIdentifier: "ButtonTVCell", for: indexPath) as! ButtonTVCell
        
        if indexPath.row == 0{
          
            cell.label.text = "Open in Browser"
            cell.icon.image = UIImage(systemName: "globe")
        }
        else
        {
            cell.label.text = "Add to bookmark"
            cell.icon.image = UIImage(systemName: "star")
        
    
        }
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
          
            
        }
        else
        {
           
        
    
        }
    }
    
}

@available(iOS 13.0, *)
extension UIView{
    func addShadow(){
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.systemGray3.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
}
