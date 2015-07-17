//
//  MainViewController.swift
//  FourInARow
//
//  Created by rony klein on 4/30/15.
//  Copyright (c) 2015 rony klein. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var name1 = ""
    var name2 = ""
    @IBOutlet weak var nameText1: UITextField!
    
    @IBOutlet weak var nameText2: UITextField!
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBAction func startGameButton(sender: UIButton) {
        name1 = nameText1.text
        name2 = nameText2.text
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "startId"{
            let nextVC = segue.destinationViewController as! CollectionViewGameBoardViewController
            
            nextVC.name1 = nameText1.text
            nextVC.name2 = nameText2.text
        }
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "startId"{
            //check strings
            if (nameText1.text == "") || (nameText2.text == "") {
                alertLabel.text = "please enter players names"
                NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "timerAction", userInfo: nil, repeats: false)
            
                return false
            }
            else {
                return true
            }
            
        
        }
       // return true
        return true
        
    }
    
    func timerAction(){
        alertLabel.text = ""
    }
    
    

}
