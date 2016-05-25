//
//  CustomCollectionViewCell.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 18.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    // Basic variables
    var title : UILabel!
    var imageView : UIImageView!
    var aCounts : UILabel!
    
    required init(coder aDecoder : NSCoder) {
        super.init(coder : aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        imageView = UIImageView(frame: CGRectMake(0, 0, frame.size.width, 130))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        let tvFrame = CGRectMake(10, 140, self.imageView.frame.width-10, 50)
        title = UILabel(frame: tvFrame)
        title.font = UIFont.systemFontOfSize(13.0)
        title.textColor = .blackColor()
        title.backgroundColor = .whiteColor()
        title.textAlignment = .Left
        title.numberOfLines = 2
        title.lineBreakMode = .ByWordWrapping
        contentView.addSubview(title)
        
        let cFrame = CGRectMake(10, 170, self.imageView.frame.width-10, 10)
        aCounts = UILabel(frame: cFrame)
        aCounts.font = UIFont.systemFontOfSize(12.0)
        aCounts.textColor = .grayColor()
        aCounts.backgroundColor = .whiteColor()
        aCounts.textAlignment = .Left
        aCounts.numberOfLines = 1
        contentView.addSubview(aCounts)
    }
}
