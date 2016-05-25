//
//  GreenViewController.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 19.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {

    // Basic variables
    var titleA : String?
    var iconName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 11/255.0, green: 171/255.0, blue: 23/255.0, alpha: 1.0)
        
        // Icon setup
        self.iconName = "check-icon"
        let image = UIImage(named: self.iconName!)
        let imageV = UIImageView(image : image!)
        imageV.frame = CGRectMake(self.view.frame.width/3+30, self.view.frame.height/2.5, 50, 50)
        imageV.contentMode = .ScaleAspectFill
        imageV.clipsToBounds = true
        self.view.addSubview(imageV)
        
        // Text setup
        self.titleA = "You found the right answer!"
        let titleLabel = UILabel(frame: CGRectMake(30, (self.view.frame.height/2.5) + 20, self.view.frame.width-60, 120))
        titleLabel.text = self.titleA
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 4
        titleLabel.font = UIFont.boldSystemFontOfSize(22.0)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = .whiteColor()
        self.view.addSubview(titleLabel)
    }
}
