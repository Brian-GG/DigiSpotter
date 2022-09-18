//
//  ViewController.swift
//  watchtest
//
//  Created by Brian Grigore on 2022-09-17.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    func sessionReachabilityDidChange(_ session: WCSession) {
        print("sesion rechability changed")
    }
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    var session: WCSession?
    @IBOutlet var restvar: UITextField!
    @IBOutlet var setvar: UITextField!
    @IBOutlet var repvar: UITextField!
    override func viewDidLoad() {
        print("hi")
        super.viewDidLoad()
        self.configureWatchKitSesstion()
        // Do any additional setup after loading the view.
    }

    func configureWatchKitSesstion() {
       
       if WCSession.isSupported() {//4.1
         session = WCSession.default//4.2
         session?.delegate = self//4.3
         session?.activate()//4.4
           print("activated session")
       }
     }
    
    @IBAction func start(_ sender: Any) {
    
        let resttime = restvar.text!
        let setnum = setvar.text!
        let repnum = repvar.text!
        print(self.session)
        print(self.session?.isReachable)
        if let validSession = self.session, validSession.isReachable {//5.1
            print("session is valid")
            let data: [String: Any] = ["Rest time": resttime, "Set num": setnum, "Rep num": repnum] // Create your Dictionay as per uses
             validSession.sendMessage(data, replyHandler: nil, errorHandler: nil)
            print("sent message")
           }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("received message: \(message)")
        
      }
}

