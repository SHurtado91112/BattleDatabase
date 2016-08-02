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

    @IBOutlet weak var btnSignIn: UIButton!
    
    var ninjaData : NinjaInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignIn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    @IBAction func signInAction(sender: AnyObject)
    {
        let username = self.userNameTextField.text
        let password = self.passWordTextField.text
        
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        let passWordInfo = ModelManager.getInstance().getNinjaPassWord(username!, pass: password!)
        
        if(passWordInfo)
        {
            Util.invokeAlertMethod("", strBody: "Login Successful!", delegate: nil)
            Globals.currentUser = username!
            Globals.currentPass = password!
            
            self.performSegueWithIdentifier("verifiedSegue", sender: sender)
        }
        else
        {
            Util.invokeAlertMethod("", strBody: "Login Failure.", delegate: nil)
        }
        
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
