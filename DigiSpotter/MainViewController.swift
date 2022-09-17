//
//  MainViewController.swift
//  DigiSpotter
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var timeField: UITextField!
    @IBOutlet var setsField: UITextField!
    @IBOutlet var repsFields: UITextField!
    
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
            print("Number of sets not set)
            return
        }
        
        if repsFields.text?.isEmpty == true{
            print("Number of reps not set")
            return
        }
        
        upload()
    }
                  
    func upload(){
        let breakTimeVar = timeField.text
        let setsVar = setsField.text
        let repsVar = repsFields.text
        
        
    }
    
}
