//
//  BasicDetailViewController.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 18.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import SwiftyJSON

class BasicDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleNav: UINavigationItem!
    var badBtn = UIButton(type: .System) as UIButton
    var numOfTaps : Int = 1
    
    var goodBtn = UIButton(type: .System) as UIButton
    
    var qTitle1 : String = ""
    var coverImage1 : NSData!
    var qDescription = [JSON]()
    var firstItem : String = ""
    var descLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
                
        let image = UIImage(data: self.coverImage1)
        let imageV = UIImageView(image : image!)
        imageV.frame = CGRectMake(0, 60, self.view.frame.width, 250)
        imageV.contentMode = .ScaleAspectFill
        imageV.clipsToBounds = true
        
        self.view.addSubview(imageV)
        
        let titleLabel = UILabel(frame: CGRectMake(10, 135, self.view.frame.width-30, 80))
        titleLabel.text = self.qTitle1
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 4
        titleLabel.font = UIFont.boldSystemFontOfSize(18.0)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = .whiteColor()
        self.view.addSubview(titleLabel)
        
        self.descLabel = UILabel(frame: CGRectMake(20, self.view.frame.height/2 + 20, self.view.frame.width-60, 120))
        
        func getFirstItem() -> String {
            
            for item in 0...0 {
            print (self.qDescription[item]["answer"].string!)
            self.firstItem = self.qDescription[item]["answer"].string!
            
            }
            return self.firstItem
        }
        
        self.descLabel.text = getFirstItem()
        
        self.descLabel.textAlignment = .Center
        self.descLabel.lineBreakMode = .ByWordWrapping
        self.descLabel.numberOfLines = 20
        self.descLabel.textColor = .blackColor()
        self.view.addSubview(self.descLabel)
        
        // let button = UIButton(type: .System) as UIButton
        self.badBtn.frame = CGRectMake(0, self.view.frame.height-35, self.view.frame.width/2, 40)
        self.badBtn.backgroundColor = UIColor(red: 235/255.0, green: 20/255.0, blue: 77/255.0, alpha: 1.0)
        self.badBtn.tintColor = .whiteColor()
        self.badBtn.setTitle("BAD", forState: UIControlState.Normal)
        
        self.view.addSubview(self.badBtn)
        
        self.goodBtn.frame = CGRectMake(0+self.view.frame.width/2, self.view.frame.height-35, self.view.frame.width/2, 40)
        self.goodBtn.backgroundColor = UIColor(red: 11/255.0, green: 171/255.0, blue: 23/255.0, alpha: 1.0)
        self.goodBtn.tintColor = .whiteColor()
        self.goodBtn.setTitle("GOOD", forState: UIControlState.Normal)
        
        self.view.addSubview(self.goodBtn)
        
        self.badBtn.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        
    }

    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func getRed() {
        let AnswerViewController =  TransitionViewController() as! UIViewController
        
        let a = self.navigationController?.radialPushViewController(AnswerViewController, duration: 1.0, startFrame: badBtn.frame, transitionCompletion: nil)
        
        
        
        delay(2) {
            
            self.navigationController!.popViewControllerAnimated(true)
        }
    
    }
    
    func buttonPressed(sender: UIButton!) {
        
        
        
        delay(1) {
        var n = self.numOfTaps
        for item in n...n {
            print (self.qDescription[item]["answer"].string!)
            
            // self.firstItem = self.qDescription[item]["answer"].string!
            self.descLabel.text = self.qDescription[item]["answer"].string!
            if self.qDescription[item]["is_right"] == true {
                self.getRed()
            }
        }
        
       
        
        if self.qDescription.count-1 != self.numOfTaps {
            self.numOfTaps += 1
        }
        else {
            print ("last item")
        }
        }
        // self.badBtn.setTitle("Bad", forState: UIControlState.Normal)
    }

    
    
    @IBAction func goodAnswer(sender: UIButton) {
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
