//
//  SignUpViewController.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 6/22/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passWordTextField: UITextField!
    
    @IBOutlet weak var verifyTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegister.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpBtn(sender: AnyObject) {
        
        let username = userNameTextField.text
        
        let exists = ModelManager.getInstance().getNinjaUserName(username!)
       
        if(exists)
        {
            Util.invokeAlertMethod("", strBody: "Username exists.",delegate: nil)
        }
        else
        {
        
            let ninjaInfo: NinjaInfo = NinjaInfo()
            ninjaInfo.Name = ""
            ninjaInfo.RegisNum = ""
            ninjaInfo.Rank = ""
            ninjaInfo.Strength = ""
            ninjaInfo.UserName = username!
            if(passWordTextField.text! != "" && passWordTextField.text! == verifyTextField.text!)
            {
                ninjaInfo.PassWord = passWordTextField.text!
                let canCreate = ModelManager.getInstance().addNinjaData(ninjaInfo)
                if canCreate {
                    Util.invokeAlertMethod("", strBody: "User created.", delegate: nil)
                    self.performSegueWithIdentifier("loginSegue", sender: sender)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in creating user.", delegate: nil)
                }

            }
            else
            {
                Util.invokeAlertMethod("", strBody: "Error: Failed Password Confirmation. ", delegate: nil)
            }
        }
    }

    /*
     
     let isUpdated = ModelManager.getInstance().updateNinjaData(ninjaInfo)
     if isUpdated {
     Util.invokeAlertMethod("", strBody: "Record updated successfully.", delegate: nil)
     } else {
     Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
     }
 
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
 

}