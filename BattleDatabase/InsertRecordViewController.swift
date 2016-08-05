//
//  InsertRecordViewController.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 6/4/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

class InsertRecordViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtMarks: UITextField!
    
    @IBOutlet weak var txtRank: UITextField!
    
    @IBOutlet weak var txtStrength: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var isEdit : Bool = false
    var ninjaData : NinjaInfo!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(isEdit)
        {
            txtName.text = ninjaData.Name
            txtMarks.text = ninjaData.RegisNum
            txtRank.text = ninjaData.Rank
            txtStrength.text = ninjaData.Strength
        }
        
        self.imageView.image = UIImage(named: "Drawing (2)")

        // Do any additional setup after loading the view.
        btnSave.layer.cornerRadius = 10
        btnSave.layer.shadowOffset = CGSizeMake(5,5)
        btnSave.layer.shadowRadius = 1
        btnSave.layer.shadowOpacity = 0.5
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnBackClicked(sender: AnyObject)
    {
    }
    
    @IBAction func btnSaveClicked(sender: AnyObject)
    {
        if(txtName.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter ninja name.", delegate: nil)
        }
        else if(txtMarks.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter ninja registry number.", delegate: nil)
        }
        else if(txtRank.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter ninja rank.", delegate: nil)
        }
        else if(txtStrength.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter main strength.", delegate: nil)
        }
        else
        {
            if(isEdit)
            {
                let ninjaInfo: NinjaInfo = NinjaInfo()
                ninjaInfo.RollNo = ninjaData.RollNo
                ninjaInfo.Name = txtName.text!
                ninjaInfo.RegisNum = txtMarks.text!
                ninjaInfo.Rank = txtRank.text!
                ninjaInfo.Strength = txtStrength.text!
                let isUpdated = ModelManager.getInstance().updateNinjaData(ninjaInfo)
                if isUpdated {
                    self.performSegueWithIdentifier("savedSegue", sender: self)
                    Util.invokeAlertMethod("", strBody: "Record updated successfully.", delegate: nil)
                } else {
                    self.performSegueWithIdentifier("savedSegue", sender: self)
                    Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
                }
            }
            else
            {
                let ninjaInfo: NinjaInfo = NinjaInfo()
                ninjaInfo.Name = txtName.text!
                ninjaInfo.RegisNum = txtMarks.text!
                ninjaInfo.Rank = txtRank.text!
                ninjaInfo.Strength = txtStrength.text!
                ninjaInfo.UserName = Globals.currentUser
                ninjaInfo.PassWord = Globals.currentPass
                let isInserted = ModelManager.getInstance().addNinjaData(ninjaInfo)
                if isInserted {
                    self.performSegueWithIdentifier("savedSegue", sender: self)
                    Util.invokeAlertMethod("", strBody: "Record inserted successfully.", delegate: nil)
                } else {
                    self.performSegueWithIdentifier("savedSegue", sender: self)
                    Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                }
            }
        }
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
