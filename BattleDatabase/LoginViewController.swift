//
//  LoginViewController.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 6/22/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!

    @IBOutlet weak var passWordTextField: UITextField!

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    var ninjaData : NinjaInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignIn.layer.cornerRadius = 10
        btnSignIn.layer.shadowOffset = CGSize(width: 5,height: 5)
        btnSignIn.layer.shadowRadius = 1
        btnSignIn.layer.shadowOpacity = 0.5
        
        activitySpinner.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    @IBAction func signInAction(_ sender: AnyObject)
    {
        var timer = Timer()
        
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        
        let username = self.userNameTextField.text
        let password = self.passWordTextField.text
        
        timer.invalidate()
        
        let userCheck = ModelManager.getInstance().getNinjaUserName(username!)
        
        let passWordInfo = ModelManager.getInstance().getNinjaPassWord(username!, pass: password!)
        
        if(username! == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter a username.", delegate: nil)
            activitySpinner.stopAnimating()
            activitySpinner.isHidden = true
        }
        else if(!userCheck)
        {
            Util.invokeAlertMethod("", strBody: "Account does not exist.", delegate: nil)
            activitySpinner.stopAnimating()
            activitySpinner.isHidden = true
        }
        else if(passWordInfo)
        {
            Globals.currentUser = username!
            Globals.currentPass = password!
         
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)

        }
        else
        {
            Util.invokeAlertMethod("", strBody: "Login Failure.", delegate: nil)
            activitySpinner.stopAnimating()
            activitySpinner.isHidden = true
        }
        
    }
    
    func delayedAction() {
        print("Timer Called")
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
        self.performSegue(withIdentifier: "verifiedSegue", sender: self)
        Util.invokeAlertMethod("", strBody: "Login Successful!", delegate: nil)
    }
/*
    @IBAction func pushSignUpView(sender: AnyObject) {
        self.performSegueWithIdentifier("signUpSegue", sender: sender)
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "registerSegue")
        {
            
            //let btnEdit : UIButton = sender as! UIButton
            //let selectedIndex : Int = btnEdit.tag
            let controller: LoginViewController = segue.destinationViewController as! LoginViewController
  
            //let viewController : LoginViewController = segue.destinationViewController as! LoginViewController
            //viewController.isEdit = true
            //viewController.ninjaData = marrNinjaData.objectAtIndex(selectedIndex) as! NinjaInfo
        }

        
    }*/
    

}
