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
    
    var goodBtn = UIButton(type: .System) as UIButton
    
    var qTitle1 : String = ""
    var coverImage1 : NSData!
    var qDescription = [JSON]()
    var firstItem : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.titleNav.title = qTitle1
        
        let image = UIImage(data: self.coverImage1)
        let imageV = UIImageView(image : image!)
        imageV.frame = CGRectMake(0, 0, self.view.frame.width, 250)
        imageV.contentMode = .ScaleAspectFill
        imageV.clipsToBounds = true
        
        self.view.addSubview(imageV)
        
        let titleLabel = UILabel(frame: CGRectMake(0, 100, self.view.frame.width, 50))
        titleLabel.text = self.qTitle1
        titleLabel.textAlignment = .Center
        titleLabel.textColor = .whiteColor()
        self.view.addSubview(titleLabel)
        
        let descLabel = UILabel(frame: CGRectMake(0, 200, self.view.frame.width, 120))
        
        func getFirstItem() -> String {
            
            for item in 0...0 {
            print (self.qDescription[item]["answer"].string!)
            self.firstItem = self.qDescription[item]["answer"].string!
            
            }
            return self.firstItem
        }
        
        descLabel.text = getFirstItem()
        
        descLabel.textAlignment = .Left
        descLabel.lineBreakMode = .ByWordWrapping
        descLabel.numberOfLines = 20
        descLabel.textColor = .blackColor()
        self.view.addSubview(descLabel)
        
        // let button = UIButton(type: .System) as UIButton
        self.badBtn.frame = CGRectMake(0, self.view.frame.height-35, self.view.frame.width/2, 40)
        self.badBtn.backgroundColor = .greenColor()
        self.badBtn.setTitle("Good", forState: UIControlState.Normal)
        
        self.view.addSubview(self.badBtn)
        
        self.goodBtn.frame = CGRectMake(0+self.view.frame.width/2, self.view.frame.height-35, self.view.frame.width/2, 40)
        self.goodBtn.backgroundColor = .redColor()
        self.goodBtn.setTitle("Good", forState: UIControlState.Normal)
        
        self.view.addSubview(self.goodBtn)
        
        self.badBtn.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        
    }

    
    
    func buttonPressed(sender: UIButton!) {
        self.badBtn.setTitle("Bad", forState: UIControlState.Normal)
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
