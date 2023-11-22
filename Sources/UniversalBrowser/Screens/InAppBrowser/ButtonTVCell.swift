//
//  ButtonTVCell.swift
//  
//
//  Created by MD SAKIBUL ALAM UTCHAS_0088 on 9/11/23.
//

import UIKit

class ButtonTVCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
