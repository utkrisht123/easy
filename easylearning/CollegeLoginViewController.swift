//
//  CollegeLoginViewController.swift
//  easylearning
//
//  Created by Utkrisht Mittal on 03/12/15.
//  Copyright © 2015 gyansha. All rights reserved.
//

import UIKit

class CollegeLoginViewController: UIViewController {

    @IBOutlet weak var Selector: UISegmentedControl!
    @IBOutlet weak var Roll: UITextField!
    @IBOutlet weak var Submit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Selector.setEnabled(true, forSegmentAtIndex: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func SelectorAction(sender: UISegmentedControl) {
        if Selector.isEnabledForSegmentAtIndex(0){
            self.performSegueWithIdentifier("CollegeToIndidvidualLoginSegue", sender: self)
        }
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
