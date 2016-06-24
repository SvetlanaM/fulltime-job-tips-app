//
//  BasicDetailViewController.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 18.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import SwiftyJSON

class BasicDetailViewController: UIViewController, UIAlertViewDelegate {
    
    // Basic variables
    @IBOutlet weak var titleNav: UINavigationItem!
    var badBtn = UIButton(type: .Custom) as UIButton
    var numOfTaps : Int = 1
    var goodBtn = UIButton(type: .Custom) as UIButton
    var shareBtn = UIButton(type: .Custom) as UIButton
    var qTitle1 : String = ""
    var coverImage1 : NSData!
    var qDescription = [JSON]()
    var firstItem : String = ""
    var descLabel : UILabel!
    var titleLabel : UILabel!
    var imageV : UIImageView!
    var countGood : Int = 0
    var countBad : Int = 0
    var sumArray = [Int]()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.integerForKey("Points")
        print (token)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        // Image setup
        let image = UIImage(data: self.coverImage1)
        self.imageV = UIImageView(image : image!)
        self.imageV.frame = CGRectMake(0, 60, self.view.frame.width, 200)
        self.imageV.contentMode = .ScaleAspectFill
        self.imageV.clipsToBounds = true
        self.view.addSubview(imageV)
        
        // Title setup
        self.titleLabel = UILabel(frame: CGRectMake(10, 115, self.view.frame.width-30, 80))
        self.titleLabel.text = self.qTitle1
        self.titleLabel.lineBreakMode = .ByWordWrapping
        self.titleLabel.numberOfLines = 4
        self.titleLabel.font = UIFont.boldSystemFontOfSize(18.0)
        self.titleLabel.textAlignment = .Center
        self.titleLabel.textColor = .whiteColor()
        self.view.addSubview(titleLabel)
        
        // Answer setup
        self.descLabel = UILabel(frame: CGRectMake(20, self.view.frame.height/2 + 10, self.view.frame.width-60, 150))
        
        // First answer
        func getFirstItem() -> String {
            for item in 0...0 {
            self.firstItem = self.qDescription[item]["answer"].string!
            }
            return self.firstItem
        }
        
        self.descLabel.text = getFirstItem()
        self.descLabel.textAlignment = .Center
        self.descLabel.lineBreakMode = .ByWordWrapping
        self.descLabel.numberOfLines = 30
        self.descLabel.textColor = .blackColor()
        self.view.addSubview(self.descLabel)
        
        // Bad button setup
        let badBtnImage = UIImage(named : "bad-icon")
        self.badBtn.frame = CGRectMake((self.view.frame.width - self.view.frame.width/2.0) + 40, self.view.frame.height-115, 40, 40)
        self.badBtn.setImage(badBtnImage, forState: .Normal)
        self.view.addSubview(self.badBtn)
        self.badBtn.addTarget(self, action: "buttonBad:", forControlEvents: .TouchUpInside)
        
        // Good button setup
        self.goodBtn.frame = CGRectMake((self.view.frame.width - self.view.frame.width/2.0) - 90, self.view.frame.height-115, 40, 40)
        let goodBtnImage = UIImage(named : "ok-icon")
        self.goodBtn.setImage(goodBtnImage, forState: .Normal)
        self.view.addSubview(self.goodBtn)
        self.goodBtn.addTarget(self, action: "buttonGood:", forControlEvents: .TouchUpInside)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        self.tabBarController?.tabBar.hidden = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        self.tabBarController?.tabBar.hidden = false
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.integerForKey("Points")
        defaults.setObject(token + self.countGood, forKey: "Points")
        defaults.synchronize()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
    }
    
    // Delay function
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // Get red controller
    func getRed() {
        let AnswerViewController =  TransitionViewController() as UIViewController
        self.navigationController?.radialPushViewController(AnswerViewController, duration: 0.3, startFrame: badBtn.frame, transitionCompletion: nil)
        delay(2) {
            self.navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // Get green controller
    func getGreen() {
        let AnswerViewController =  GreenViewController() as UIViewController
        self.navigationController?.radialPushViewController(AnswerViewController, duration: 0.3, startFrame: goodBtn.frame, transitionCompletion: nil)
        delay(2) {
            self.navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // Get grey controller
    func getGrey() {
        let AnswerViewController =  GreyViewController() as UIViewController
        self.navigationController?.radialPushViewController(AnswerViewController, duration: 0.3, startFrame: badBtn.frame, transitionCompletion: nil)
        delay(2) {
            self.navigationController!.popViewControllerAnimated(true)
        }
    }
    
    func getPoints(n : Int) {
        if n == 30 {
            showAlert("You won \"Your recruiter is sad\" badge. Go to badges to see your reward.")
        }
        else if n == 60 {
            showAlert("You won \"Your recruiter is not sure about you\" badge. Go to badges to see your reward.")
        }
        else if n == 90 {
            showAlert("You won \"Your recruiter is impressed!\" badge. Go to badges to see your reward.")
        }
        else {
            print ("None badge")
        }
        
    }
    
    func showAlert(message : String) {
        // Alert view
        let alertController = UIAlertController(title: "You gain a badge!", message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: {
            (action) -> Void in print("ok")
        })
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Bad answer logic
    func buttonBad(sender: UIButton!) {
        delay(0.5) {
        let n = self.numOfTaps
        for item in n...n {
            if self.qDescription[item]["is_right"] == true {
                self.getRed()
                
            }
            else  {
                self.getGreen()
                self.countGood += 1
                self.delay(0.7) {
                    let defaults = NSUserDefaults.standardUserDefaults()
                    let token = defaults.integerForKey("Points")
                    self.getPoints(token)
                }
                
            }
            
            self.descLabel.text = self.qDescription[item]["answer"].string!
        }
        
        if self.qDescription.count-1 != self.numOfTaps {
            self.numOfTaps += 1
        }
        else {
            self.imageV.frame = CGRectMake(0, 60, self.view.frame.width, 200)
            self.titleLabel.text = "Congratulations!"
            
            
            self.descLabel.text = "You succesfully finished \(self.qTitle1) section with \(self.countGood) good answers! Now you can continue with the next question sections and learn more to be more prepared on the interview."
            self.badBtn.hidden = true
            self.goodBtn.hidden = true
            
            }
        }
    }
    
    // Right answer logic
    func buttonGood(sender: UIButton!) {
        delay(0.5) {
            let n = self.numOfTaps
            for item in n...n {
                if self.qDescription[item]["is_right"] == true {
                    self.getGreen()
                    self.countGood += 1
                    self.delay(0.7) {
                    let defaults = NSUserDefaults.standardUserDefaults()
                    let token = defaults.integerForKey("Points")
                    self.getPoints(token)
                    }
                }
                else {
                    self.getRed()
                }
                self.descLabel.text = self.qDescription[item]["answer"].string!
            }
            
            if self.qDescription.count-1 != self.numOfTaps {
                self.numOfTaps += 1
                
            }
            else {
                self.imageV.frame = CGRectMake(0, 60, self.view.frame.width, 200)
                self.titleLabel.text = "Congratulations!"
                self.descLabel.text = "You succesfully finished \(self.qTitle1) section with \(self.countGood) good answers! Now you can continue with the next question sections and learn more to be more prepared on the interview."
                self.badBtn.hidden = true
                self.goodBtn.hidden = true
                
                
            }
        }
    }
    
    
    
}
