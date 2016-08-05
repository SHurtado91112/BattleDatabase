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
    
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegister.layer.cornerRadius = 10
        btnRegister.layer.shadowOffset = CGSizeMake(5,5)
        btnRegister.layer.shadowRadius = 1
        btnRegister.layer.shadowOpacity = 0.5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpBtn(sender: AnyObject) {
        
        var timer = NSTimer()
        
        activitySpinner.hidden = false
        activitySpinner.startAnimating()
        
        timer.invalidate()

        
        let username = userNameTextField.text
        
        let exists = ModelManager.getInstance().getNinjaUserName(username!)
       
        if(exists)
        {
            Util.invokeAlertMethod("", strBody: "Error: Username Exists.",delegate: nil)
        }
        else
        {
        
            let ninjaInfo: NinjaInfo = NinjaInfo()
            ninjaInfo.Name = ""
            ninjaInfo.RegisNum = ""
            ninjaInfo.Rank = ""
            ninjaInfo.Strength = ""
            ninjaInfo.UserName = username!
            if(passWordTextField.text! != "" && userNameTextField.text! != "" && passWordTextField.text! == verifyTextField.text!)
            {
                ninjaInfo.PassWord = passWordTextField.text!
                let canCreate = ModelManager.getInstance().addNinjaData(ninjaInfo)
                if canCreate {
                    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error: Failed to Create User.", delegate: nil)
                }

            }
            else if(userNameTextField.text! == "")
            {
                Util.invokeAlertMethod("", strBody: "Error: No Username Entered.", delegate: nil)
            }
            else
            {
                Util.invokeAlertMethod("", strBody: "Error: Failed Password Confirmation. ", delegate: nil)
            }
        }
    }

    func delayedAction() {
        print("Timer 0 Called")
        activitySpinner.stopAnimating()
        activitySpinner.hidden = true
        self.performSegueWithIdentifier("registeredSegue", sender: self)
        Util.invokeAlertMethod("", strBody: "User Created.", delegate: nil)

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
