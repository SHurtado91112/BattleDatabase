//
//  ModelManager.swift
//  BattleDatabase
//
//  Created by Steven Hurtado on 6/4/16.
//  Copyright © 2016 Hurtado_Steven. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject
{
    var database: FMDatabase? = nil
    
    // This code is called at most once
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("Ninja.sqlite"))
        }
        return sharedInstance
    }
    
    //function that checks for username availability
    func getNinjaUserName(user: String) -> Bool
    {
        
        var username = ""
        sharedInstance.database!.open()
        let usernameSet = sharedInstance.database!.executeQuery("SELECT UserName FROM ninja_info WHERE UserName = '" + user + "'", withArgumentsInArray: nil)
       
        var x = 0;
        while usernameSet.next()
        {
            print("loop: " + String(x))
            if(usernameSet.stringForColumn("UserName") != nil)
            {
                break;
            }
            x += 1;
        }
        
        if(usernameSet.stringForColumn("UserName") == nil)
        {
            return false;
        }
        
        username = usernameSet.stringForColumn("UserName")
        
        sharedInstance.database!.close()
        
        //print("user : " + user)
        print(username)
        print(user == username)

        return user == username
    }
    
    //function that checks login conditions for username and password
    func getNinjaPassWord(user: String, pass: String) -> Bool
    {
        sharedInstance.database!.open()
        let usernameSet = sharedInstance.database!.executeQuery("SELECT UserName, PassWord FROM ninja_info WHERE UserName = '" + user + "'", withArgumentsInArray: nil)
        
        while usernameSet.next()
        {
            if(usernameSet.stringForColumn("UserName") != nil)
            {
                print(usernameSet.stringForColumn("UserName"))
                break;
            }
        }
        if(usernameSet.stringForColumn("UserName") == nil)
        {
            return false;
        }
        
        let username = usernameSet.stringForColumn("UserName")
        
        let password = usernameSet.stringForColumn("PassWord")
        
        sharedInstance.database!.close()
        
        print(user + " :U: " + username)
        print(pass + " :P: " + password)
        
        return user == username && pass == password
    }
    
    func addNinjaData(ninjaInfo: NinjaInfo) -> Bool
    {
        sharedInstance.database!.open()
        
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO ninja_info (Name, RegistryNum, Rank, Strength, UserName, PassWord) VALUES (?, ?, ?, ?, ?, ?)", withArgumentsInArray: [ninjaInfo.Name, ninjaInfo.RegisNum, ninjaInfo.Rank, ninjaInfo.Strength, ninjaInfo.UserName, ninjaInfo.PassWord])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateNinjaData(ninjaInfo: NinjaInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE ninja_info SET Name=?, RegistryNum=?, Rank=?, Strength=? WHERE RollNo=?", withArgumentsInArray: [ninjaInfo.Name, ninjaInfo.RegisNum, ninjaInfo.Rank, ninjaInfo.Strength, ninjaInfo.RollNo])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteNinjaData(ninjaInfo: NinjaInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM ninja_info WHERE RollNo=?", withArgumentsInArray: [ninjaInfo.RollNo])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func deleteUser(nin: String) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM ninja_info WHERE UserName=?", withArgumentsInArray: [nin])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func getAllNinjaData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM ninja_info", withArgumentsInArray: nil)
        let marrNinjaInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            
            //retrieve values for table cells
            while resultSet.next()
            {
                let ninjaInfo : NinjaInfo = NinjaInfo()
                ninjaInfo.RollNo = resultSet.stringForColumn("RollNo")
                ninjaInfo.Name = resultSet.stringForColumn("Name")
                ninjaInfo.RegisNum = resultSet.stringForColumn("RegistryNum")
                ninjaInfo.Rank = resultSet.stringForColumn("Rank")
                ninjaInfo.Strength = resultSet.stringForColumn("Strength")
                ninjaInfo.UserName = resultSet.stringForColumn("UserName")
                ninjaInfo.PassWord = resultSet.stringForColumn("PassWord")
                
                //if values have not been set up yet (username/password created but no information created)
                //then ignore
                if(resultSet.stringForColumn("Name") != "")
                {
                    marrNinjaInfo.addObject(ninjaInfo)
                }
            }
        }
        sharedInstance.database!.close()
        
        return marrNinjaInfo
    }
}