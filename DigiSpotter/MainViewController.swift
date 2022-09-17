//
//  MainViewController.swift
//  DigiSpotter
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainViewController: UIViewController {

    @IBOutlet var timeField: UITextField!
    @IBOutlet var setsField: UITextField!
    @IBOutlet var repsField: UITextField!
    
    var timeVar: String = ""
    var setsVar: String = ""
    var repsVar: String = ""
    
    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calls hide keyboard func
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func uploadBtnPressed(_ sender: Any) {
        
        if timeField.text?.isEmpty == true{
            print("No time set")
            return
        }
        
        if setsField.text?.isEmpty == true{
            print("Number of sets not set")
            return
        }
        
        if repsField.text?.isEmpty == true{
            print("Number of reps not set")
            return
        }
        
        addNewEntry()
    }
                  
    @objc private func addNewEntry(){
        timeVar = timeField.text!
        setsVar = setsField.text!
        repsVar = repsField.text!
        
        database.child("something").setValue(timeVar)
    }
    
}
