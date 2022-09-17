//
//  MainViewController.swift
//  DigiSpotter
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController {
    
    let userUID = Auth.auth().currentUser?.uid
    
    private let database = Database.database().reference()
    
    var currentDateTime: String = ""
    var selectedExercise: String = "Squats"
    var arraySize: Int = 0
    
    @IBOutlet var restTimeField: UITextField!
    @IBOutlet var setsField: UITextField!
    @IBOutlet var repsField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        database.child(userUID!).observeSingleEvent(of: .value, with: { snapshot in
            // Get user value
            if let dictionary = snapshot.value as? [String: Any]{
                self.arraySize = dictionary[""] as! Int
            }
          }) { error in
            print(error.localizedDescription)
          }
        
        // Calls hide keyboard func
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func uploadBtnPressed(_ sender: Any) {
        
        if restTimeField.text?.isEmpty == true{
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
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        currentDateTime = dateFormatter.string(from: date)
        
        let info: [String: Any] = [
            "start-time": currentDateTime,
            "end-time": 0,
            "sets": setsField.text!,
            "reps": repsField.text!,
            "rest-time": restTimeField.text!,
        ]
        
        arraySize += 1
            
        database.child("users").child(userUID!).child(selectedExercise).child(String(arraySize)).setValue(info)
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        addEndDateTime()
    }
    
    @objc private func addEndDateTime(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        currentDateTime = dateFormatter.string(from: date)
        
        let info: [String: Any] = [
            "end-time": currentDateTime,
        ]
            
        database.child("users").child(userUID!).child(selectedExercise).child(String(arraySize)).updateChildValues(info)
    }
    
    
//    @IBAction func historyPageBtn(_ sender: Any) {
//        // Changes storyboard to login page
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "history")
//        vc?.modalPresentationStyle = .overFullScreen
//        self.present(vc!, animated: true)
//    }
}
