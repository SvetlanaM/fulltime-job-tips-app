//
//  SmartQuestionViewController.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 23.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SmartQuestionViewController: UIViewController {
    
    // Basic variables
    let smartQuestionURL = "https://pdimensions2016.herokuapp.com/api/questions/smart/"
    var badBtn = UIButton(type: .Custom) as UIButton
    var numOfTaps : Int = 1
    var goodBtn = UIButton(type: .Custom) as UIButton
    var qTitle1 : String = ""
    var imageURL : NSURL!
    var qDescription = [JSON]()
    var firstItem : String = ""
    var descLabel : UILabel!
    var titleLabel : UILabel!
    var imageV : UIImageView!
    var smartQuestions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem?.title = "Ask HR"
        
        // Download smart questions
        getSmartQuestions()
        
        // Label setup
        self.descLabel = UILabel(frame: CGRectMake(20, self.view.frame.height/2.6, self.view.frame.width-60, 120))
        self.descLabel.textAlignment = .Center
        self.descLabel.lineBreakMode = .ByWordWrapping
        self.descLabel.numberOfLines = 20
        self.descLabel.textColor = .blackColor()
        self.view.addSubview(self.descLabel)
        
        // Bad button setup
        let badBtnImage = UIImage(named : "bad-icon")
        self.badBtn.frame = CGRectMake((self.view.frame.width - self.view.frame.width/2.0) + 40, self.view.frame.height-175, 40, 40)
        self.badBtn.setImage(badBtnImage, forState: .Normal)
        self.view.addSubview(self.badBtn)
        self.badBtn.addTarget(self, action: "buttonBad:", forControlEvents: .TouchUpInside)
        
        // Good button setup
        self.goodBtn.frame = CGRectMake((self.view.frame.width - self.view.frame.width/2.0) - 90, self.view.frame.height-175, 40, 40)
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
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
    }

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
    
    // Download smart questions data
    func getSmartQuestions() {
        Alamofire.request(.GET, self.smartQuestionURL)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let smartData = JSON(response.result.value!)
                    for (index, subJson) : (String, JSON) in smartData {
                        let smartQuestion = Question(id: subJson["id"].int!, title: subJson["title"].string!, proTip: subJson["pro_tip"].string!, coverImage: subJson["cover_image"].string!, normalImage: subJson["cover_image"].string!)
                        smartQuestion.answerSet = subJson["answer_set"].array!
                        self.smartQuestions.append(smartQuestion)
                        
                        // Image setup
                        self.imageURL = NSURL(string: self.smartQuestions[0].coverImage)
                        var imageData = NSData(contentsOfURL: self.imageURL!)
                        let image = UIImage(data : imageData!)
                        self.imageV = UIImageView(image : image!)
                        self.imageV.frame = CGRectMake(0, 0, self.view.frame.width, 200)
                        self.imageV.contentMode = .ScaleAspectFill
                        self.imageV.clipsToBounds = true
                        self.view.addSubview(self.imageV)
                        
                        // Title setup
                        self.titleLabel = UILabel(frame: CGRectMake(10, 55, self.view.frame.width-30, 80))
                        self.titleLabel.text = self.smartQuestions[0].title
                        self.titleLabel.lineBreakMode = .ByWordWrapping
                        self.titleLabel.numberOfLines = 4
                        self.titleLabel.font = UIFont.boldSystemFontOfSize(18.0)
                        self.titleLabel.textAlignment = .Center
                        self.titleLabel.textColor = .whiteColor()
                        self.view.addSubview(self.titleLabel)
                        
                        // Answer setup
                        func getFirstItem() -> String {
                            for item in 0...0 {
                                self.firstItem = self.smartQuestions[0].answerSet[0]["answer"].string!
                            }
                            return self.firstItem
                        }
                        
                        self.descLabel.text = getFirstItem()
                        self.descLabel.textAlignment = .Center
                        self.descLabel.lineBreakMode = .ByWordWrapping
                        self.descLabel.numberOfLines = 30
                        self.descLabel.textColor = .blackColor()
                        self.view.addSubview(self.descLabel)
                    }
                case .Failure(let error):
                    print (error)
                }
        }
    }
    
    
    func buttonBad(sender: UIButton!) {
        self.delay(0.4) {
            let n = self.numOfTaps
            for item in n...n {
                if self.smartQuestions[0].answerSet[self.numOfTaps]["is_right"] == true {
                    self.getRed()
                }
                else {
                    self.getGreen()
                }
                
                self.descLabel.text = self.smartQuestions[0].answerSet[self.numOfTaps]["answer"].string!
            }
            
            if self.smartQuestions[0].answerSet.count-1 != self.numOfTaps {
                self.numOfTaps += 1
            }
            else {
                self.numOfTaps = 1
            }
        }
    }
    
    func buttonGood(sender: UIButton!) {
        self.delay(0.4) {
            let n = self.numOfTaps
            for item in n...n {
                if self.smartQuestions[0].answerSet[self.numOfTaps]["is_right"] == true {
                    self.getGreen()
                }
                else {
                    self.getRed()
                }
                self.descLabel.text = self.smartQuestions[0].answerSet[self.numOfTaps]["answer"].string!
                            }
            if self.smartQuestions[0].answerSet.count-1 != self.numOfTaps {
                self.numOfTaps += 1
            }
            else {
                self.numOfTaps = 1
            }
        }
    }
}
