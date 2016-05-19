//
//  TransitionViewController.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 19.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    
    var titleA : String?
    
    var iconName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    func getRed() {
        self.view.backgroundColor = UIColor(red: 235/255.0, green: 20/255.0, blue: 77/255.0, alpha: 1.0)
        
        self.iconName = "uncheck-icon"
        
        let image = UIImage(named: self.iconName!)
        let imageV = UIImageView(image : image!)
        imageV.frame = CGRectMake(self.view.frame.width/3+30, 250, 50, 50)
        imageV.contentMode = .ScaleAspectFill
        imageV.clipsToBounds = true
        
        self.view.addSubview(imageV)
        
        self.titleA = "Bad choice. This answer is good!"
        let titleLabel = UILabel(frame: CGRectMake(30, 300, self.view.frame.width-60, 120))
        titleLabel.text = self.titleA
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.numberOfLines = 4
        titleLabel.font = UIFont.boldSystemFontOfSize(22.0)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = .whiteColor()
        self.view.addSubview(titleLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
