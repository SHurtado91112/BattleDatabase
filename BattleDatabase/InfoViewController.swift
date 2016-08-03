//
//  InfoViewController.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 8/2/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var numLbl: UILabel!
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var strengthLbl: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    var ninjaData : NinjaInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = ninjaData.Name
        numLbl.text = ninjaData.RegisNum
        rankLbl.text = ninjaData.Rank
        strengthLbl.text = ninjaData.Strength
        
        self.imageView.image = UIImage(named: "Drawing (3)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
