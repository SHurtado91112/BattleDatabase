//
//  RevealTableViewCell.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 8/4/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

class RevealTableViewCell: UITableViewCell {

    @IBOutlet weak var cLbl: UILabel!
    
    @IBOutlet weak var cBtn: UIButton!
    
    @IBOutlet weak var activitySpinner2: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
