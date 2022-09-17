//
//  LoginViewController.swift
//  DigiSpotter
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    // User input text fields
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calls hide keyboard func
        self.hideKeyboardWhenTappedAround()
    }
    
    // Action for when login btn pressed
    @IBAction func loginBtnPressed(_ sender: Any) {
        validateFields()
    }
    
    // Action for when create account pressed
    @IBAction func createAccountPressed(_ sender: Any) {
        // Changes storyboard page to signup page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "signup")
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    // Validates email and password fields
    func validateFields(){
        // Checks to see if user input fields are empty
        if emailField.text?.isEmpty == true{
            print("Email Field Empty")
            return
        }
        
        if passwordField.text?.isEmpty == true{
            print("Password Field Empty")
            return
        }
        
        login()
    }
    
    // Passes email and password imput fields into firebase auth
    func login(){
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { [weak self] authResult, error in
            guard let strongSelf = self else {return}
            
            if let error = error{
                print(error.localizedDescription)
            }
            self!.checkUserInfo()
        }
    }
    
    // Checks firebase auth for if user exists
    func checkUserInfo(){
        if Auth.auth().currentUser != nil{
            print(Auth.auth().currentUser?.uid)
            
            // Changes storyboard page to main page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "main")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
}
