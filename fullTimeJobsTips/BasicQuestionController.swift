//
//  BasicViewController.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 17.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BasicViewController: UICollectionViewController
{
    let basicQuestionURL = "https://dimensions2016.herokuapp.com/api/questions/basic"
    
    var basicQuestions = [Question]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBasicQuestion()
        
        //collectionView?.bac
        
        
        
        
    }
    
    func getBasicQuestion() {
        Alamofire.request(.GET, self.basicQuestionURL)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let basicData = JSON(response.result.value!)
                    
                    for (index, subJson) : (String, JSON) in basicData {
                        let basicQuestion = Question(id : subJson["id"].int!, title : subJson["title"].string!, proTip : subJson["pro_tip"].string!, coverImage : subJson["cover_image"].string!, normalImage : subJson["normal_image"].string!)
                    self.basicQuestions.append(basicQuestion)
                    }
                    print (self.basicQuestions[1].title)
                case .Failure(let error):
                    print (error)
                }
                
        }
        
    }

}
