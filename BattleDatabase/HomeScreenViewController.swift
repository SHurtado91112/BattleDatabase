//
//  HomeScreenViewController.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 6/4/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var marrNinjaData : NSMutableArray!
    @IBOutlet weak var tbNinjaData: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.userLabel.text! = Globals.currentUser
        self.imageView.image = UIImage(named: "Drawing (1)")
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
        
        cell.lblContent.text = "Name : \(ninja.Name) Rank : \(ninja.Rank)"
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        return cell
    }
    

    
    @IBAction func btnDeleteClicked(sender: AnyObject)
    {
        let btnDelete : UIButton = sender as! UIButton
        let selectedIndex : Int = btnDelete.tag
        let ninjaInfo: NinjaInfo = marrNinjaData.objectAtIndex(selectedIndex) as! NinjaInfo
        let isDeleted = ModelManager.getInstance().deleteNinjaData(ninjaInfo)
        if isDeleted {
            Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
        } else {
            Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
        }
        self.getNinjaData()
    }
    
    @IBAction func btnEditClicked(sender: AnyObject)
    {
        self.performSegueWithIdentifier("editSegue", sender: sender)
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
    }

}
