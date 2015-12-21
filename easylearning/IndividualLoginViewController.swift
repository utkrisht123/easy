//
//  IndividualViewController.swift
//  easylearning
//
//  Created by Utkrisht Mittal on 02/12/15.
//  Copyright © 2015 gyansha. All rights reserved.
//

import UIKit

class IndividualLoginViewController: UIViewController {
   
    @IBOutlet weak var Selector: UISegmentedControl!
    @IBOutlet weak var UserNameTextView: UITextField!
    @IBOutlet weak var PasswordTextView: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!
    var overlay : UIView?
    var activityIndicator = UIActivityIndicatorView()
    var LD : LoginData = LoginData()
    let dHCV : UIViewController = HomeScreenViewController()
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
Selector.setEnabled(true, forSegmentAtIndex: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func LoginButton(sender: AnyObject) {
        
        
       let semaphore :dispatch_semaphore_t = dispatch_semaphore_create(0);
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            if (self.UserNameTextView.text!.isEmpty || self.PasswordTextView.text!.isEmpty){
                let alertController = UIAlertController(title: "Empty", message: "Your Feilds are Empty", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            else{
                 self.loadingScreen("start")
                dispatch_semaphore_signal(semaphore)
                self.LD.userName = self.UserNameTextView.text!
                self.LD.PassWord = self.PasswordTextView.text!
                self.LD.call_Login()
                
                if (self.LD.responce == 1){
                    print(self.LD.responce)
                    self.loadingScreen("stop")
                    self.performSegueWithIdentifier("SegueToMainScreen", sender: self)
                    
                }
                else if (self.LD.responce == 0){
                    print(self.LD.responce)
                    let aletView = UIAlertController(title: "Invalid", message: "Wrong Username Password", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "Retry", style: .Default, handler: nil)
                    aletView.addAction(defaultAction)
                    self.presentViewController(aletView, animated: true, completion: nil)
                    self.loadingScreen("stop")
                }

            }
           
            
        }
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
       
        
        
    }
    func loadingScreen(state: String?){
        
      
        overlay = UIView(frame: view.frame)
        overlay?.tag = 123;
        switch (state!){
        
            case "start":
                print("Loading Screen Start")
                overlay!.backgroundColor = UIColor.blackColor()
                overlay!.alpha = 0.8
                view.addSubview(overlay!)
                activityIndicator.frame = CGRectMake(0, 0, 40, 40)
                activityIndicator.activityIndicatorViewStyle = .WhiteLarge
                activityIndicator.center = CGPointMake(overlay!.bounds.width / 2, overlay!.bounds.height / 2)
                overlay!.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                  UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            break
            case "stop":
                print("Loading Screen stop")
                view.viewWithTag(123)?.removeFromSuperview()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            break
         default: break
            
                }
    }
    @IBAction func SelectorAction(sender: UISegmentedControl) {
        
        if Selector.isEnabledForSegmentAtIndex(1){
            self.performSegueWithIdentifier("IndividualToCollegeLoginSegue", sender: self)
        }
    }

}
