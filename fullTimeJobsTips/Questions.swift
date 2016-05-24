//
//  Questions.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 17.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import SwiftyJSON

class Question: NSObject {
    var id : Int
    var title : String
    var proTip : String
    var coverImage : String
    var normalImage : String
    var answerSet = [JSON]()
    
    init(id : Int, title : String, proTip : String, coverImage : String, normalImage : String) {
        self.id = id
        self.title = title
        self.proTip = proTip
        self.coverImage = coverImage
        self.normalImage = normalImage
    }

}

class AboutAuthor : NSObject {
    var id : Int
    var firstName : String
    var lastName : String
    var phoneNumber : String
    var linkedin : String
    var website : String
    var userPhoto : String
    var aDescription: String
    
    init(id : Int, firstName : String, lastName : String, phoneNumber : String, linkedin : String, website : String, userPhoto : String, aDescription : String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.linkedin = linkedin
        self.website = website
        self.userPhoto = userPhoto
        self.aDescription = aDescription
    }
    
    
}
