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
    func getNinjaUserName(_ user: String) -> Bool
    {
        
        var username = ""
        sharedInstance.database!.open()
        let usernameSet = sharedInstance.database!.executeQuery("SELECT UserName FROM ninja_info WHERE UserName = '" + user + "'", withArgumentsIn: nil)
       
        var x = 0;
        while (usernameSet?.next())!
        {
            print("loop: " + String(x))
            if(usernameSet?.string(forColumn: "UserName") != nil)
            {
                break;
            }
            x += 1;
        }
        
        if(usernameSet?.string(forColumn: "UserName") == nil)
        {
            return false;
        }
        
        username = (usernameSet?.string(forColumn: "UserName"))!
        
        sharedInstance.database!.close()
        
        //print("user : " + user)
        print(username)
        print(user == username)

        return user == username
    }
    
    //function that checks login conditions for username and password
    func getNinjaPassWord(_ user: String, pass: String) -> Bool
    {
        sharedInstance.database!.open()
        let usernameSet = sharedInstance.database!.executeQuery("SELECT UserName, PassWord FROM ninja_info WHERE UserName = '" + user + "'", withArgumentsIn: nil)
        
        while (usernameSet?.next())!
        {
            if(usernameSet?.string(forColumn: "UserName") != nil)
            {
                print(usernameSet?.string(forColumn: "UserName"))
                break;
            }
        }
        if(usernameSet?.string(forColumn: "UserName") == nil)
        {
            return false;
        }
        
        let username = usernameSet?.string(forColumn: "UserName")
        
        let password = usernameSet?.string(forColumn: "PassWord")
        
        sharedInstance.database!.close()
        
        print(user + " :U: " + username!)
        print(pass + " :P: " + password!)
        
        return user == username && pass == password
    }
    
    func addNinjaData(_ ninjaInfo: NinjaInfo) -> Bool
    {
        sharedInstance.database!.open()
        
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO ninja_info (Name, RegistryNum, Rank, Strength, UserName, PassWord) VALUES (?, ?, ?, ?, ?, ?)", withArgumentsIn: [ninjaInfo.Name, ninjaInfo.RegisNum, ninjaInfo.Rank, ninjaInfo.Strength, ninjaInfo.UserName, ninjaInfo.PassWord])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateNinjaData(_ ninjaInfo: NinjaInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE ninja_info SET Name=?, RegistryNum=?, Rank=?, Strength=? WHERE RollNo=?", withArgumentsIn: [ninjaInfo.Name, ninjaInfo.RegisNum, ninjaInfo.Rank, ninjaInfo.Strength, ninjaInfo.RollNo])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteNinjaData(_ ninjaInfo: NinjaInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM ninja_info WHERE RollNo=?", withArgumentsIn: [ninjaInfo.RollNo])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func deleteUser(_ nin: String) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM ninja_info WHERE UserName=?", withArgumentsIn: [nin])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func getAllNinjaData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM ninja_info", withArgumentsIn: nil)
        let marrNinjaInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            
            //retrieve values for table cells
            while resultSet.next()
            {
                let ninjaInfo : NinjaInfo = NinjaInfo()
                ninjaInfo.RollNo = resultSet.string(forColumn: "RollNo")
                ninjaInfo.Name = resultSet.string(forColumn: "Name")
                ninjaInfo.RegisNum = resultSet.string(forColumn: "RegistryNum")
                ninjaInfo.Rank = resultSet.string(forColumn: "Rank")
                ninjaInfo.Strength = resultSet.string(forColumn: "Strength")
                ninjaInfo.UserName = resultSet.string(forColumn: "UserName")
                ninjaInfo.PassWord = resultSet.string(forColumn: "PassWord")
                
                //if values have not been set up yet (username/password created but no information created)
                //then ignore
                if(resultSet.string(forColumn: "Name") != "")
                {
                    marrNinjaInfo.add(ninjaInfo)
                }
            }
        }
        sharedInstance.database!.close()
        
        return marrNinjaInfo
    }
}
