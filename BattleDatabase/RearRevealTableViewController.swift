//
//  RearRevealTableViewController.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 8/4/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

class RearRevealTableViewController: UITableViewController {

    var cellsArray = [Globals]()
    var imageArray = [UIImage]()
    
    //declared mutable cell for multiple func scope
    var cell : RevealTableViewCell! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initializing arrays for cell creation
        self.cellsArray = [Globals(cellLabel: "User: " + Globals.currentUser), Globals(cellLabel: "About"), Globals(cellLabel: "Log Out"), Globals(cellLabel: "Delete Account")]
        
        self.imageArray = [UIImage(named: "homeIMG")!, UIImage(named: "aboutIMG")!, UIImage(named: "logOutIMG")!, UIImage(named: "deleteIMG")!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.cellsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //setting up each cell
        cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RevealTableViewCell
        
        var cellName : Globals
        cellName = cellsArray[indexPath.row]
        
        var image : UIImage
        image = self.imageArray[indexPath.row]
        
        cell.cLbl.text = cellName.cellLabel
        cell.cBtn.setImage(image, forState: UIControlState.Normal)
        cell.cBtn.tintColor = UIColor.init(red: CGFloat(250/255.0), green: CGFloat(70/255.0), blue: CGFloat(22/255.0), alpha: 1)
        return cell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //conditional for cell selection
        if(indexPath.row == 0)
        {
            print("User clicked")
        }
        else if(indexPath.row == 1)
        {
            self.performSegueWithIdentifier("aboutSegue", sender: self)
        }
        else if(indexPath.row == 2)
        {
            var timer2 = NSTimer()
            timer2.invalidate()
            
            cell.activitySpinner2.startAnimating()
            cell.activitySpinner2.hidden = false
            
            timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(delayedAction2), userInfo: nil, repeats: false)
        }
        else
        {
            let alert = UIAlertController(title: "Wait!", message: "Are you sure you want to delete this account and all of its records?" as String, preferredStyle: .ActionSheet)
            let action1 = UIAlertAction(title: "Yes", style: .Destructive)
            { _ in
                let isDeleted = ModelManager.getInstance().deleteUser(Globals.currentUser)
                if isDeleted {
                    
                    var timer2 = NSTimer()
                    timer2.invalidate()
                    
                    self.cell.activitySpinner2.startAnimating()
                    self.cell.activitySpinner2.hidden = false
                    
                    timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.delayedAction3), userInfo: nil, repeats: false)
                }
                else
                {
                    Util.invokeAlertMethod("", strBody: "Error in deleting user.", delegate: nil)
                }

            }
            let action2 = UIAlertAction(title: "No", style: .Default)
            { _ in
                Util.invokeAlertMethod("", strBody: "User data not deleted.", delegate: nil)
            }
            
            alert.addAction(action1)
            alert.addAction(action2)
            
            self.presentViewController(alert, animated: true){}
        }
    }
    
    func delayedAction2()
    {
        
        print("Timer 3 Called")
        cell.activitySpinner2.stopAnimating()
        cell.activitySpinner2.hidden = true
        self.performSegueWithIdentifier("logOutSegue", sender: self)
        Util.invokeAlertMethod("", strBody: "Log Out Successful!", delegate: nil)
    }
    
    func delayedAction3()
    {
        
        print("Timer 4 Called")
        cell.activitySpinner2.stopAnimating()
        cell.activitySpinner2.hidden = true
        self.performSegueWithIdentifier("logOutSegue", sender: self)
        Util.invokeAlertMethod("", strBody: "User data deleted successfully.", delegate: nil)
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
