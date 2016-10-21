//
//  RearRevealTableViewController.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 8/4/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

class RearRevealTableViewController: UITableViewController
{

    var cellsArray = [Globals]()
    var imageArray = [UIImage]()
    
    //declared mutable cell for multiple func scope
    var cell : RevealTableViewCell! = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //initializing arrays for cell creation
        self.cellsArray = [Globals(cellLabel: "User: " + Globals.currentUser), Globals(cellLabel: "About"), Globals(cellLabel: "Log Out"), Globals(cellLabel: "Delete Account")]
        
        self.imageArray = [UIImage(named: "homeIMG")!, UIImage(named: "aboutIMG")!, UIImage(named: "logOutIMG")!, UIImage(named: "deleteIMG")!]
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.cellsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //setting up each cell
        cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RevealTableViewCell
        
        var cellName : Globals
        cellName = cellsArray[(indexPath as NSIndexPath).row]
        
        var image : UIImage
        image = self.imageArray[(indexPath as NSIndexPath).row]
        
        cell.cLbl.text = cellName.cellLabel
        cell.cBtn.setImage(image, for: UIControlState())
        cell.cBtn.tintColor = UIColor.init(red: CGFloat(250/255.0), green: CGFloat(70/255.0), blue: CGFloat(22/255.0), alpha: 1)
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //conditional for cell selection
        if((indexPath as NSIndexPath).row == 0)
        {
            print("User clicked")
        }
        else if((indexPath as NSIndexPath).row == 1)
        {
            self.performSegue(withIdentifier: "aboutSegue", sender: self)
        }
        else if((indexPath as NSIndexPath).row == 2)
        {
            self.performSegue(withIdentifier: "homeSegue", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Wait!", message: "Are you sure you want to delete this account and all of its records?" as String, preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "Yes", style: .destructive)
            { _ in
                let isDeleted = ModelManager.getInstance().deleteUser(Globals.currentUser)
                if isDeleted
                {
                    self.performSegue(withIdentifier: "deleteUserSegue", sender: self)
                }
                else
                {
                    Util.invokeAlertMethod("", strBody: "Error in deleting user.", delegate: nil)
                }

            }
            let action2 = UIAlertAction(title: "No", style: .default)
            { _ in
                Util.invokeAlertMethod("", strBody: "User data not deleted.", delegate: nil)
            }
            
            alert.addAction(action1)
            alert.addAction(action2)
            
            self.present(alert, animated: true){}
        }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "homeSegue")
        {
            Globals.logOutBool = true
        }
        else if(segue.identifier == "deleteUserSegue")
        {
            Globals.deleteUser = true
        }

    }
 

}
