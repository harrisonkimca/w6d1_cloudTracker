//
//  LoginViewController.swift
//  2w6d1_foodTracker
//
//  Created by Seantastic31 on 01/08/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var newaccountLabel: UILabel!
    
    
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    

    //MARK: Actions
    // https://ericcerney.com/swift-guard-statement/
    // https://thatthinginswift.com/guard-statement-swift/
    @IBAction func signup(_ sender: UIButton)
    {
        guard let userInput = usernameField.text, isValid(userInput: userInput) else
        {
            alertUser(title: "Invalid Username", message: "Username must contain at least 6 characters")
            return
        }
        
        guard let passwordInput = passwordField.text, isValid(userInput: passwordInput) else
        {
            alertUser(title: "Invalid Password", message: "Password must contain at least 6 characters")
            return
        }
        
        print ("Signup button pressed")
    }
    
    
    @IBAction func login(_ sender: UIButton)
    {
        guard let userInput = usernameField.text, isValid(userInput: userInput) else
        {
            alertUser(title: "Invalid Username", message: "Username must contain at least 6 characters")
            return
        }
        
        guard let passwordInput = passwordField.text, isValid(userInput: passwordInput) else
        {
            alertUser(title: "Invalid Password", message: "Password must contain at least 6 characters")
            return
        }
        print ("Login button pressed")
    }
    
    
    
    

    
    
    
    
    
    
    //MARK: UITextFieldDelegate
   
    
    //MARK: Private Methods
    // https://www.appcoda.com/uialertcontroller-swift-closures-enum/
    private func alertUser(title: String, message: String) -> Void
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // https://stackoverflow.com/questions/37938435/swift-validate-username-input
    private func isValid(userInput: String) -> Bool
    {
        let RegEx = "\\A\\w{6,16}\\z"
        let Test = NSPredicate(format: "SELF MATCHES %@", RegEx)
        return Test.evaluate(with:userInput)
    }
    
    
    
}
