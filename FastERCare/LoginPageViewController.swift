//
//  LoginPageViewController.swift
//  FastERCare
//
//  Created by Steven Creekmore on 12/26/15.
//  Copyright © 2015 Steven Creekmore. All rights reserved.
//
import UIKit
import RealmSwift
//import Foundation

class LoginPageViewController: UIViewController {
    
    //var datasource: Results<FastUsers>!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(userEmailTextField: UITextField) -> Bool {
        userEmailTextField.resignFirstResponder()
        return true
    }
    func text2FieldShouldReturn(userPasswordTextField: UITextField) -> Bool {
        userPasswordTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        // check to make sure no fields are empty
        if((userEmailTextField.text == "") || (userPasswordTextField.text == ""))
        {
            displayMyAlertMessage("All fields are required")
            return
        }
        
        var result = UserDataController.verifyUser(userEmailTextField.text! , userPWD:userPasswordTextField.text!)
        print("Results: \(result)")
        
            if(result)
            {
            
            NSUserDefaults.standardUserDefaults().setBool(true,forKey:"isUserLoggedIn");
            self.dismissViewControllerAnimated(true, completion:nil);
            }
            let myAlert = UIAlertController(title:"Alert", message:"UserID and or Password not found", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
                    self.dismissViewControllerAnimated(true, completion:nil);
                }
                myAlert.addAction(okAction);
               self.presentViewController(myAlert, animated:true, completion:nil);
            
        }
        
    
    
    
        


    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion:nil )
    }
    

}