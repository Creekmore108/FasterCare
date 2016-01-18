//
//  UserDataController.swift
//  FastERCare
//
//  Created by Steven Creekmore on 1/6/16.
//  Copyright © 2016 Steven Creekmore. All rights reserved.
//

import RealmSwift
import UIKit

class UserDataController: Object {
    
    class func saveUser(User : FastUsers)
    {
        do
        {
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(User)
                print("new User added \(User)")
            })
        }
        catch
        {
            print("Error in saving User")   
        }
    }
    

    class func verifyUser(userID: String, userPWD: String) -> Bool
    {
        let userIDL = dropCase(userID)
        print("user IDL: \(userIDL)")
        
        do
        {
            let realm = try Realm()
            let predicate = NSPredicate(format: "UserName = %@ AND UserPassword = %@", (userIDL), (userPWD))
            let result = realm.objects(FastUsers).filter(predicate)
            let Good = result.count
            //print("IS VALID: \(Good)")
            //print("user: \(userIDL), PWD: \(userPWD)")
            
        
            if(Good == 1){
                do{
                let fast = realm.objects(FastUsers)
                try! realm.write{
                    let results = fast.filter(predicate)
                    results[0].LoggedIn = true
                    results[0].LastLoggedIn = NSDate(timeIntervalSinceNow: 1)
                    print("Verify User Results: \(results)")
                    }
                }
                //catch{
                //    print("fell through the write try")
                //    return false
                //}
                
               return true
            }else{
                return false
            }
        }
        catch
        {
            print("nothing to return")
            return true
        }
    }
    
    class func userLogout()
    {

        do
        {
            let realm = try Realm()
            let predicate = NSPredicate(format: "LoggedIn = %@", (true))
            let res = realm.objects(FastUsers).filter(predicate)
            try realm.write{
                res[0].LoggedIn = false
                print("Logout Results: \(res)")
            }
            //let Good = result.count
            //print("IS VALID: \(Good)")
            //print("user: \(userIDL), PWD: \(userPWD)")
            
            
            //if(Good == 1){
              //  do{
                    //let fast = realm.objects(FastUsers)
                    //try! realm.write{
                       // //let results = fast.filter(predicate)
                        //let result
            
                   // }
               // }
                
                //return true
            //}else{
                //return false
           // }//
        }
        catch
        {
            print("nothing to return")
            //return true
        }

    }

    class func dropCase(InString:String) -> String
    {
        return InString.lowercaseString
    }
}
