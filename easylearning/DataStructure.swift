//
//  DataStructure.swift
//  easylearning
//
//  Created by Utkrisht Mittal on 14/12/15.
//  Copyright © 2015 gyansha. All rights reserved.
//

import Foundation
import UIKit

enum state{
    case new,failed,compleated
}

class LoginData {
    var userName: String?
    var PassWord: String?
    var responce : Int = -1
    var error : NSError? = nil
    var status = state.new
   
    init(userName: String, PassWord: String){
        self.userName = userName
        self.PassWord = PassWord
        self.responce = -1
    }
    init(){
        self.userName = nil
        self.PassWord = nil
        self.responce = -1
    }
    
    func call_Login() {
        
        let semaphore :dispatch_semaphore_t = dispatch_semaphore_create(0);
        let url = "http://admin.gyansha.co.in/AdminAPI/rest/admin/login?user_name=\(self.userName!)&password=\(self.PassWord!)"
        //let url = "http://admin.gyansha.co.in/AdminAPI/rest/admin/login?user_name=gyansha_admin&password=Facebook.com1"
        print(url)
        let nsurl: NSURL = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            let task = session.dataTaskWithURL(nsurl){ (data,response,error) in
                
                if error == nil{
                    let json = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary)
                    if let records = json["records"] as? NSArray{
                        if let data = records[0] as? NSDictionary{
                           
                            self.responce = data["Response"] as! Int
                            
                            
                        }
                        else{
                            self.status = state.failed
                            self.error = error!
                            print("Error!!!")
                        }
                    }
                    else{
                        self.status = state.failed
                        self.error = error!
                    }
                }
                else{
                    self.status = state.failed
                    self.error = error!
                }
               dispatch_semaphore_signal(semaphore)
                
            }.resume()
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            
        }
        
        
    }
    
}