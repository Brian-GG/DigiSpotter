//
//  SignupViewController.swift
//  DigiSpotter
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController {

    // User input text fields
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    // Action for when user has account pressed
    @IBAction func haveAccountPressed(_ sender: Any) {
        // Changes storyboard to login page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    // Action for when signup btn pressed
    @IBAction func signupBtnTapped(_ sender: Any) {
        // Checks to see if user input fields are empty
        if emailField.text?.isEmpty == true{
            print("No text in email field")
            return
        }
        
        if passwordField.text?.isEmpty == true{
            print("no text in password field")
            return
        }
        
        signUp()
    }
    
    // Uses user input fields for firebare to auth user
    func signUp(){
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else{
                print("Error \(error?.localizedDescription)")
                return
            }
            
            // Changes storyboard page to main page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: true)
   
        }
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
