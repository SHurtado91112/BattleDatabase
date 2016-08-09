//
//  HomeScreenViewController.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 6/4/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//
//TO-DO List:
// - remove username showing
// - password confidentiality

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var marrNinjaData : NSMutableArray!
    @IBOutlet weak var tbNinjaData: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    //@IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var activitySpinner2: UIActivityIndicatorView!
    
    @IBOutlet weak var open: UIBarButtonItem!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.userLabel.text! = Globals.currentUser
        self.imageView.image = UIImage(named: "Drawing (1)")
        
        self.activitySpinner2.hidden = true
        self.activitySpinner2.stopAnimating()
        if(revealViewController() != nil)
        {
            open.target = revealViewController()
            open.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        if(Globals.logOutBool == true)
        {
            var timer2 = NSTimer()
            timer2.invalidate()
            
            self.activitySpinner2.hidden = false
            self.activitySpinner2.startAnimating()
            
            timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(delayedAction2), userInfo: nil, repeats: false)
            
        }
        else if(Globals.deleteUser == true)
        {
            var timer2 = NSTimer()
            timer2.invalidate()
            
            self.activitySpinner2.hidden = false
            self.activitySpinner2.startAnimating()
            
            timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(delayedAction3), userInfo: nil, repeats: false)
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.getNinjaData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNinjaData()
    {
        marrNinjaData = NSMutableArray()
        marrNinjaData = ModelManager.getInstance().getAllNinjaData()
        tbNinjaData.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return marrNinjaData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:NinjaCell = tableView.dequeueReusableCellWithIdentifier("cell") as! NinjaCell
        let ninja:NinjaInfo = marrNinjaData.objectAtIndex(indexPath.row) as! NinjaInfo
        
        if(ninja.UserName != Globals.currentUser)
        {
            cell.btnDelete.backgroundColor = UIColor.blackColor()
            cell.btnEdit.backgroundColor = UIColor.blackColor()
        }
        
        cell.lblContent.text = "\(ninja.Name) \(ninja.UserName)"
        cell.btnInfo.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        return cell
    }
    

    @IBAction func btnViewClicked(sender: AnyObject)
    {
        self.performSegueWithIdentifier("infoSegue", sender: sender)
    }
    
    @IBAction func btnDeleteClicked(sender: AnyObject)
    {
        let btnDelete : UIButton = sender as! UIButton
        let selectedIndex : Int = btnDelete.tag
        let ninjaInfo: NinjaInfo = marrNinjaData.objectAtIndex(selectedIndex) as! NinjaInfo
        
        //checking for proper user
        if(ninjaInfo.UserName == Globals.currentUser)
        {
            //action sheet for deletion of record
            let alert = UIAlertController(title: "Wait!", message: "Are you sure you want to delete this record?" as String, preferredStyle: .ActionSheet)
            let action1 = UIAlertAction(title: "Yes", style: .Destructive)
            { _ in
                let isDeleted = ModelManager.getInstance().deleteNinjaData(ninjaInfo)
                if isDeleted {
                    Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
                }
                self.getNinjaData()
                
            }
            let action2 = UIAlertAction(title: "No", style: .Default)
            { _ in
                Util.invokeAlertMethod("", strBody: "Record not deleted.", delegate: nil)
            }
            
            alert.addAction(action1)
            alert.addAction(action2)
            
            self.presentViewController(alert, animated: true){}
        }
        else
        {
            Util.invokeAlertMethod("", strBody: "Cannot Delete: Improper Permissions.", delegate: nil)
        }
        
    }
    
    @IBAction func btnEditClicked(sender: AnyObject)
    {
        let btnEdit : UIButton = sender as! UIButton
        let selectedIndex : Int = btnEdit.tag
        let ninjaInfo: NinjaInfo = marrNinjaData.objectAtIndex(selectedIndex) as! NinjaInfo
        
        if(ninjaInfo.UserName == Globals.currentUser)
        {
            self.performSegueWithIdentifier("editSegue", sender: sender)
        }
        else
        {
            Util.invokeAlertMethod("", strBody: "Cannot Edit: Improper Permissions.", delegate: nil)
        }
    }
    
    func delayedAction2()
    {
        
        print("Timer 3 Called")
    
        Globals.logOutBool = false
        self.activitySpinner2.hidden = true
        self.activitySpinner2.stopAnimating()
        
        self.performSegueWithIdentifier("logOutSegue", sender: self)
        Util.invokeAlertMethod("", strBody: "Log Out Successful!", delegate: nil)
    }
    
    func delayedAction3()
    {
        
        print("Timer 4 Called")
        Globals.deleteUser = false
        self.activitySpinner2.hidden = true
        self.activitySpinner2.stopAnimating()
        
        self.performSegueWithIdentifier("logOutSegue", sender: self)
        Util.invokeAlertMethod("", strBody: "User data deleted successfully.", delegate: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "editSegue")
        {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            let viewController : InsertRecordViewController = segue.destinationViewController as! InsertRecordViewController
            viewController.isEdit = true
            viewController.ninjaData = marrNinjaData.objectAtIndex(selectedIndex) as! NinjaInfo
        }
        else if(segue.identifier == "infoSegue")
        {
            let btnInfo : UIButton = sender as! UIButton
            let selectedIndex : Int = btnInfo.tag
            let viewController : InfoViewController = segue.destinationViewController as! InfoViewController
            viewController.ninjaData = marrNinjaData.objectAtIndex(selectedIndex) as! NinjaInfo
        }

    }

}
