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
    let smartQuestionURL = "https://dimensions2016.herokuapp.com/api/questions/smart"
    
    var badBtn = UIButton(type: .System) as UIButton
    var numOfTaps : Int = 1
    
    var goodBtn = UIButton(type: .System) as UIButton
    var shareBtn = UIButton(type: .System) as UIButton
    
    var qTitle1 : String = ""
    var imageURL : NSURL!
    var qDescription = [JSON]()
    var firstItem : String = ""
    var descLabel : UILabel!
    
    var titleLabel : UILabel!
    var imageV : UIImageView!
    
    var smartQuestions = [Question]()
    var myView : UIViewController?
    
    var navBar = UINavigationController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSmartQuestions()
        self.descLabel = UILabel(frame: CGRectMake(20, self.view.frame.height/2 + 20, self.view.frame.width-60, 120))
        self.descLabel.textAlignment = .Center
        self.descLabel.lineBreakMode = .ByWordWrapping
        self.descLabel.numberOfLines = 20
        self.descLabel.textColor = .blackColor()
        self.view.addSubview(self.descLabel)
        self.badBtn.frame = CGRectMake(0, self.view.frame.height-170, self.view.frame.width/2, 40)
        self.badBtn.backgroundColor = UIColor(red: 235/255.0, green: 20/255.0, blue: 77/255.0, alpha: 1.0)
        self.badBtn.tintColor = .whiteColor()
        self.badBtn.setTitle("BAD", forState: UIControlState.Normal)
        self.view.addSubview(self.badBtn)
        self.goodBtn.frame = CGRectMake(0+self.view.frame.width/2, self.view.frame.height-170, self.view.frame.width/2, 40)
        self.goodBtn.backgroundColor = UIColor(red: 11/255.0, green: 171/255.0, blue: 23/255.0, alpha: 1.0)
        self.goodBtn.tintColor = .whiteColor()
        self.goodBtn.setTitle("GOOD", forState: UIControlState.Normal)
        self.view.addSubview(self.goodBtn)
        self.badBtn.addTarget(self, action: "buttonBad:", forControlEvents: .TouchUpInside)
        self.goodBtn.addTarget(self, action: "buttonGood:", forControlEvents: .TouchUpInside)
        
        self.navigationController!.navigationBar.topItem?.title = "Smart Questions"
        
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
        let AnswerViewController =  TransitionViewController() as UIViewController
        
        self.navigationController?.radialPushViewController(AnswerViewController, duration: 1.0, startFrame: badBtn.frame, transitionCompletion: nil)
        
        
        
        
        delay(0.1) {
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    func getGreen() {
        let AnswerViewController =  GreenViewController() as UIViewController
        
        self.navigationController?.radialPushViewController(AnswerViewController, duration: 1.0, startFrame: badBtn.frame, transitionCompletion: nil)
        
        
        
        delay(0.1) {
            
            self.navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    func getGrey() {
        let AnswerViewController =  GreyViewController() as! UIViewController
        
        self.navigationController?.radialPushViewController(AnswerViewController, duration: 1.0, startFrame: badBtn.frame, transitionCompletion: nil)
        delay(0.1) {
            
            self.navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
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
                        self.imageURL = NSURL(string: self.smartQuestions[0].coverImage)
                        var imageData = NSData(contentsOfURL: self.imageURL!)
                        
                        let image = UIImage(data : imageData!)
                        self.imageV = UIImageView(image : image!)
                        self.imageV.frame = CGRectMake(0, 0, self.view.frame.width, 250)
                        self.imageV.contentMode = .ScaleAspectFill
                        self.imageV.clipsToBounds = true
                        
                        self.view.addSubview(self.imageV)
                        
                        self.titleLabel = UILabel(frame: CGRectMake(10, 105, self.view.frame.width-30, 80))
                        self.titleLabel.text = self.smartQuestions[0].title
                        self.titleLabel.lineBreakMode = .ByWordWrapping
                        self.titleLabel.numberOfLines = 4
                        self.titleLabel.font = UIFont.boldSystemFontOfSize(18.0)
                        self.titleLabel.textAlignment = .Center
                        self.titleLabel.textColor = .whiteColor()
                        self.view.addSubview(self.titleLabel)
                        
                        self.descLabel = UILabel(frame: CGRectMake(20, self.view.frame.height/2 + 20, self.view.frame.width-60, 120))
                        
                        func getFirstItem() -> String {
                            
                            for item in 0...0 {
                                print (self.smartQuestions[0].answerSet[0]["answer"].string!)
                                self.firstItem = self.smartQuestions[0].answerSet[0]["answer"].string!
                                
                            }
                            return self.firstItem
                        }
                        
                        self.descLabel.text = getFirstItem()
                        
                        self.descLabel.textAlignment = .Center
                        self.descLabel.lineBreakMode = .ByWordWrapping
                        self.descLabel.numberOfLines = 20
                        self.descLabel.textColor = .blackColor()
                        self.view.addSubview(self.descLabel)
                        
                        
                        
                        
                        
                        
                        

                        
                    }
                case .Failure(let error):
                    print (error)
                }
        }
        
        
    }
    
    
    func buttonBad(sender: UIButton!) {
        self.delay(0.3) {
            let n = self.numOfTaps
            for item in n...n {
                
                self.descLabel.text = self.smartQuestions[0].answerSet[self.numOfTaps]["answer"].string!
                if self.smartQuestions[0].answerSet[self.numOfTaps]["is_right"] == true {
                    self.getRed()
                }
                else if self.smartQuestions[0].answerSet[self.numOfTaps]["is_right"] == false {
                    self.getGreen()
                }
                else {
                    self.getGrey()
                }
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
        self.delay(0.3) {
            var n = self.numOfTaps
            for item in n...n {
                
                self.descLabel.text = self.smartQuestions[0].answerSet[self.numOfTaps]["answer"].string!
                if self.smartQuestions[0].answerSet[self.numOfTaps]["is_right"] == true {
                    self.getGreen()
                }
                else if self.smartQuestions[0].answerSet[self.numOfTaps]["is_right"] == false {
                    self.getGrey()
                }
                else {
                    self.getGrey()
                }
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
