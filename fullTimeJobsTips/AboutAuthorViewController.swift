//
//  AboutAuthorViewController.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 24.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit

class AboutAuthorViewController: UIViewController {
    var aboutAuthorURL = "https://dimensions2016.herokuapp.com/api/about"
    
    var aboutAuthor = [AboutAuthor]()
    
    var authorImage : NSURL!
    var firstName : String!
    var lastName : String!
    var phoneNumber : String!
    var linkedinProfile : String!
    var website : String!
    var aDescription: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAuthorData()
        

        // Do any additional setup after loading the view.
    }
    
    func getAuthorData() {
        
        Alamofire.request(.GET, self.aboutAuthorURL)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let basicData = JSON(response.result.value!)
                    
                    for (index, subJson) : (String, JSON) in basicData {
                        let about = AboutAuthor(id: subJson["id"].int!, firstName: subJson["first_name"].string!, lastName: subJson["last_name"].string!, phoneNumber: subJson["phone_number"].string!, linkedin: subJson["linkedin_profile"].string!, website: subJson["website"].string!, userPhoto: subJson["user_photo"].string!, aDescription: subJson["description"].string!)
                        
                        self.aboutAuthor.append(about)
                    }
                    
                    var imageURL = NSURL(string: self.aboutAuthor[0].userPhoto)
                    var imageData = NSData(contentsOfURL: imageURL!)
                    var image = UIImage(data: imageData!)
                    
                    
                    
                    
                    
                case .Failure (let error):
                    print(error)
                }
        }
        
    }
    
    

    

}
