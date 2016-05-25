//
//  RewardCollectionViewCell.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 25.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit

class RewardCollectionViewCell: UICollectionViewCell {
    var iconView : UIImageView!
    var title : UILabel!
    var price : UILabel!
    
    required init(coder aDecoder : NSCoder) {
        super.init(coder : aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        iconView.contentMode = UIViewContentMode.ScaleAspectFill
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)
        
        let tvFrame = CGRectMake(80, 20, 200, 50)
        title = UILabel(frame: tvFrame)
        title.font = UIFont.systemFontOfSize(13.0)
        title.textColor = .blackColor()
        title.backgroundColor = .whiteColor()
        title.textAlignment = .Left
        title.numberOfLines = 2
        title.lineBreakMode = .ByWordWrapping
        contentView.addSubview(title)
        
        let cFrame = CGRectMake(80, 40, 200, 10)
        price = UILabel(frame: cFrame)
        price.font = UIFont.systemFontOfSize(12.0)
        price.textColor = .grayColor()
        price.backgroundColor = .whiteColor()
        price.textAlignment = .Left
        price.numberOfLines = 1
        contentView.addSubview(price)
    }
}
