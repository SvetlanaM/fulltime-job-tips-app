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
        
        
        iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 80, height: 80))
        iconView.contentMode = UIViewContentMode.ScaleAspectFill
        iconView.clipsToBounds = true
        contentView.addSubview(iconView) 
        
        let tvFrame = CGRectMake(100, 20, 200, 30)
        title = UILabel(frame: tvFrame)
        title.font = UIFont.boldSystemFontOfSize(15.0)
        title.textColor = .blackColor()
        
        title.textAlignment = .Left
        title.numberOfLines = 4
        title.lineBreakMode = .ByWordWrapping
        contentView.addSubview(title)
        
        let cFrame = CGRectMake(100, 35, 200, 60)
        price = UILabel(frame: cFrame)
        price.font = UIFont.systemFontOfSize(12.0)
        price.textColor = .grayColor()
        
        price.textAlignment = .Left
        price.numberOfLines = 2
        contentView.addSubview(price)
    }
}
