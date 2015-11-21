//
//  ViewController.swift
//  bioProtect
//
//  Created by test on 10/12/15.
//  Copyright (c) 2015 Mrtang. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    var authenticationContext:LAContext!

    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetLAContext()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func printButtonTapped(sender: AnyObject) {
        let policy = LAPolicy.DeviceOwnerAuthenticationWithBiometrics
        
        var error:NSError? = nil
        let canAuthentication = authenticationContext.canEvaluatePolicy(policy, error: &error)
        if canAuthentication == true {
            self.resultLabel.text = "可以使用指纹识别设备"
            authenticationContext.localizedFallbackTitle = "输入密码"
        }
        else {
            self.resultLabel.text = "无设备可用"
            return
        }
        
        let authenficationReason = "请使用指纹验证"
        authenticationContext.evaluatePolicy(policy, localizedReason: authenficationReason) { (success, error) -> Void in
            if success {
               // self.result1.text = ""
              let mainqueue = NSOperationQueue.mainQueue()
                mainqueue.addOperationWithBlock({ () -> Void in
                    self.resultLabel.text = "指纹识别成功"
                })
                
            }
            else {
                let mainqueue = NSOperationQueue.mainQueue()
                mainqueue.addOperationWithBlock({ () -> Void in
                    self.resultLabel.text = "指纹识别失败"
                })
            }
        }
        resetLAContext()
    }
    
    func resetLAContext() {
       self.authenticationContext = LAContext()
    }

}

