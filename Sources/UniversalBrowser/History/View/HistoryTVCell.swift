//
//  HistoryTVCell.swift
//  
//
//  Created by BJIT on 7/11/23.
//

import UIKit

class HistoryTVCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model:History){
        if let title = model.title, let url = model.url{
            lblTitle.text = title
            lblUrl.text = url
        }
    }
}
