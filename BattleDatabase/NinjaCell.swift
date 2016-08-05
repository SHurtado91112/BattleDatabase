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
    
    @IBOutlet weak var btnInfo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnEdit.layer.cornerRadius = 10
        btnDelete.layer.cornerRadius = 10
        
        btnEdit.layer.shadowOffset = CGSizeMake(3,3)
        btnEdit.layer.shadowRadius = 1
        btnEdit.layer.shadowOpacity = 0.5
        btnEdit.layer.shadowColor = UIColor.blackColor().CGColor
        
        btnDelete.layer.shadowOffset = CGSizeMake(3,3)
        btnDelete.layer.shadowRadius = 1
        btnDelete.layer.shadowOpacity = 0.5
        btnDelete.layer.shadowColor = UIColor.blackColor().CGColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
