//
//  FasterDB.swift
//  FastERCare
//
//  Created by Steven Creekmore on 1/6/16.
//  Copyright © 2016 Steven Creekmore. All rights reserved.
//
import RealmSwift
import Foundation

class FastUsers: Object {
    
    dynamic var UserName : String = ""
    dynamic var UserPassword : String = ""
    dynamic var LoggedIn : Bool = false
    dynamic var LastLoggedIn = NSDate(timeIntervalSince1970:1)
    
}
