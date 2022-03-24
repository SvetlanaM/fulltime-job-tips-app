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
    var photoBox : UIImageView!
    var userName : UILabel!
    var emailLabel : UITextView!
    var linkedinLabel : UILabel!
    
    var descriptionLabel : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAuthorData()
        addGestureRecognizer()
    }
    
    func getAuthorData() { 
        Alamofire.request(.GET, self.aboutAuthorURL)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let basicData = JSON(response.result.value!)
                    
                    for (index, subJson) : (String, JSON) in basicData {
                        let about = AboutAuthor(firstName: subJson["first_name"].string!, lastName: subJson["last_name"].string!, phoneNumber: subJson["phone_number"].string!, linkedin: subJson["linkedin_profile"].string!, website: subJson["website"].string!, userPhoto: subJson["user_photo"].string!, aDescription: subJson["description"].string!, email : subJson["email"].string!)
                        self.aboutAuthor.append(about)
                    }
                    
                    var imageURL = NSURL(string: self.aboutAuthor[0].userPhoto)
                    var imageData = NSData(contentsOfURL: imageURL!)
                    var image = UIImage(data: imageData!)
                    self.photoBox = UIImageView(image: image!)
                    self.photoBox.frame = CGRectMake(20, 80, 100, 100)
                    self.photoBox.contentMode = .ScaleAspectFill
                    self.view.addSubview(self.photoBox)
                    self.userName = UILabel(frame: CGRectMake(100, 80, 200, 200))
                    self.userName.text = String( (self.aboutAuthor[0].firstName) + " " + (self.aboutAuthor[0].lastName))
                    self.userName.textColor = .blackColor()
                    self.userName.lineBreakMode = .ByWordWrapping
                    self.userName.numberOfLines = 2
                    self.userName.font = UIFont.boldSystemFontOfSize(18.0)
                    self.userName.textAlignment = .Left
                    self.view.addSubview(self.userName)
                    self.emailLabel = UITextView(frame: CGRectMake(100, 90, 200, 200))
                    self.emailLabel.text = self.aboutAuthor[0].email
                    self.emailLabel.textColor = .blackColor()
                    self.emailLabel.editable = false
                    self.emailLabel.dataDetectorTypes = .All
                    self.emailLabel.font = UIFont.boldSystemFontOfSize(18.0)
                    self.emailLabel.textAlignment = .Left
                    self.view.addSubview(self.emailLabel)
                    self.linkedinLabel = UILabel(frame: CGRectMake(100, 180, 200, 200))
                    self.linkedinLabel.text = self.aboutAuthor[0].linkedin
                    self.linkedinLabel.textColor = .blackColor()
                    self.linkedinLabel.lineBreakMode = .ByWordWrapping
                    self.linkedinLabel.numberOfLines = 2
                    self.linkedinLabel.font = UIFont.boldSystemFontOfSize(18.0)
                    self.linkedinLabel.textAlignment = .Left
                    self.view.addSubview(self.linkedinLabel)        
                    self.descriptionLabel = UILabel(frame: CGRectMake(100, 250, 200, 200))
                    self.descriptionLabel.text = self.aboutAuthor[0].aDescription
                    self.descriptionLabel.textColor = .blackColor()
                    self.descriptionLabel.lineBreakMode = .ByWordWrapping
                    self.descriptionLabel.numberOfLines = 15
                    self.descriptionLabel.textAlignment = .Left              
                    self.view.addSubview(self.descriptionLabel)
                case .Failure (let error):
                    print(error)
                }
        }
        
    }
    
    func addGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        gestureRecognizer.addTarget(self, action: "openLinkedin")
        self.view.addGestureRecognizer(gestureRecognizer)
        self.view.userInteractionEnabled = true
    }
}
