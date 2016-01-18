//
//  ViewController.swift
//  FastERCare
//
//  Created by Steven Creekmore on 12/25/15.
//  Copyright © 2015 Steven Creekmore. All rights reserved.
//

import UIKit
import RealmSwift
//import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        do{
            let P = try Realm().path
            print("Realm path: \(P)")
        }catch {}
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
    let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if(!isUserLoggedIn)
        {
        self.performSegueWithIdentifier("loginView", sender: self )
            
        }
    }
    
    @IBAction func call911ButtonPressed(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string:"telprompt://911")!)
    }

    @IBAction func logoutButtonPressed(sender: AnyObject) {
        UserDataController.userLogout()
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.performSegueWithIdentifier("loginView", sender: self )
    }
}

