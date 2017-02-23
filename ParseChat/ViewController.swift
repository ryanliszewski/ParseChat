//
//  ViewController.swift
//  ParseChat
//
//  Created by Ryan Liszewski on 2/22/17.
//  Copyright © 2017 Smiley. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {


    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLoginButton(_ sender: Any) {
        let user = PFUser()
        user.username = userNameTextField.text
        user.password = passwordTextField.text
        
        PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) {
            (user: PFUser?, error: Error?) in
            
            if(error == nil){
                self.performSegue(withIdentifier: "ChatSegue", sender: nil)
                
            }
            
            
        }
    
    }
   
    @IBAction func onSignUpButton(_ sender: Any) {
        let user = PFUser()
        user.username = userNameTextField.text
        user.password = passwordTextField.text

        // other fields can be set just like with PFObject
        
        user.signUpInBackground { (succeeded: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                    print("Signed up!!!")
                }
        }
    }
    

}

