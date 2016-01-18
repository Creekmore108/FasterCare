//
//  RegistrationPageViewController.swift
//  FastERCare
//
//  Created by Steven Creekmore on 12/26/15.
//  Copyright © 2015 Steven Creekmore. All rights reserved.
//

import UIKit
import CoreData

class RegistrationPageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // userEmailTextField.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(userPasswordTextField: UITextField) -> Bool {
        userPasswordTextField.resignFirstResponder()
        return true
    }
    func text1FieldShouldReturn(repeatPasswordTextField: UITextField) -> Bool {
        repeatPasswordTextField.resignFirstResponder()
        return true
    }
    func text2FieldShouldReturn(userEmailTextField: UITextField) -> Bool {
        userEmailTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func registerButtonPushed(sender: AnyObject) {
        
        // check to make sure no fields are empty
        if((userEmailTextField.text == "") || (userPasswordTextField.text == "" || repeatPasswordTextField.text == ""))
        {
            displayMyAlertMessage("All fields are required")
            return
        }
        // Check that the email address is valid
        if !isValidEmail(userEmailTextField.text!) {
            displayMyAlertMessage("Not a valid email address")
            return
        }
        // check that passwords match
        if(userPasswordTextField.text != repeatPasswordTextField.text)
        {
            displayMyAlertMessage("Passwords did not match")
            return
        }
        
        // add new user
        saveUser()
        let myAlert = UIAlertController(title:"Alert", message:"Registration is successful. Thank you!", preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
                        self.dismissViewControllerAnimated(true, completion:nil);
                    }
                    
                    myAlert.addAction(okAction);
                    self.presentViewController(myAlert, animated:true, completion:nil);
        
     }// end of register button func
    
    func saveUser(){
        
        let newUser = FastUsers()
        let LowerCaseUserName = userEmailTextField.text!.lowercaseString
        newUser.UserName = LowerCaseUserName
        newUser.UserPassword = userPasswordTextField.text!
        UserDataController.saveUser(newUser)
        
    }


    // Validate email address
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    // Display Alert Message
    func displayMyAlertMessage(userMessage:String)
    {
        // create the alert
        let alert = UIAlertController(title: "Error", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        //self.dismissViewControllerAnimated(true, completion: nil)
        
    
    }
}