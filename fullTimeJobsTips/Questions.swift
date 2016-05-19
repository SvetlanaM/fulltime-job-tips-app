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
