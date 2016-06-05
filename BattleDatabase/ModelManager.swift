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
    
    func addNinjaData(ninjaInfo: NinjaInfo) -> Bool
    {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO ninja_info (Name, RegistryNum, Rank, Strength) VALUES (?, ?, ?, ?)", withArgumentsInArray: [ninjaInfo.Name, ninjaInfo.RegisNum, ninjaInfo.Rank, ninjaInfo.Strength])
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
    
    func getAllNinjaData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM ninja_info", withArgumentsInArray: nil)
        let marrNinjaInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let ninjaInfo : NinjaInfo = NinjaInfo()
                ninjaInfo.RollNo = resultSet.stringForColumn("RollNo")
                ninjaInfo.Name = resultSet.stringForColumn("Name")
                ninjaInfo.RegisNum = resultSet.stringForColumn("RegistryNum")
                ninjaInfo.Rank = resultSet.stringForColumn("Rank")
                ninjaInfo.Strength = resultSet.stringForColumn("Strength")
                marrNinjaInfo.addObject(ninjaInfo)
            }
        }
        sharedInstance.database!.close()
        
        return marrNinjaInfo
    }
}