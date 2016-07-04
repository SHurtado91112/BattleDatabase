//
//  NinjaCell.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 6/4/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

class NinjaCell: UITableViewCell {

    @IBOutlet weak var lblContent: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnEdit.layer.cornerRadius = 10
        btnDelete.layer.cornerRadius = 10
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
