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


class Reward : NSObject {
    var id : Int
    var title : String
    var badgeDescription : String
    var icon : String
    var totalPoints : Int
    var price : String
    var priceLink : String = ""
    var priceEbook : String = ""
    
    
    init(id : Int, title : String, badgeDescription : String, icon : String, totalPoints : Int, price : String) {
        self.id = id
        self.title = title
        self.badgeDescription = badgeDescription
        self.icon = icon
        self.totalPoints = totalPoints
        self.price = price
    }
    
    func changeIcon(name : String) {
        icon = name
    }
    
    func setThePriceEbook(link : String) {
        priceEbook = link
    }
    
}