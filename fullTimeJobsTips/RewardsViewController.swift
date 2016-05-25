//
//  RewardsViewController.swift
//  fullTimeJobsTips
//
//  Created by Svetlana Margetová on 25.05.16.
//  Copyright © 2016 Svetlana Margetová. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RewardsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // Basic variables
    var rewardsURL = "https://dimensions2016.herokuapp.com/api/rewards/"
    var rewards = [Reward]()
    var collection: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRewards()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8.5, left: 0, bottom: 120.5, right: 0)
        self.collection = UICollectionView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), collectionViewLayout: layout)
        self.collection!.delegate = self
        self.collection!.dataSource = self
        self.collection!.registerClass(RewardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(self.collection!)
        self.collection!.backgroundColor = UIColor(red: 206/255.0, green: 206/255.0, blue: 206/255.0, alpha: 1.0)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! RewardCollectionViewCell
        cell.backgroundColor = .whiteColor()
        let url = rewards[indexPath.row].icon
        let imageURL = NSURL(string: url)
        let imageData = NSData(contentsOfURL: imageURL!)
        cell.iconView.image = UIImage(data: imageData!)
        cell.title.text = rewards[indexPath.row].title
        cell.price.text = rewards[indexPath.row].price
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rewards.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8.5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width-20, height: 100)
    }
    
    

    func getRewards() {
        Alamofire.request(.GET, self.rewardsURL)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let rewardsData = JSON(response.result.value!)
                    for (index, subJson) : (String, JSON) in rewardsData {
                        let reward = Reward(id: subJson["id"].int!, title: subJson["title"].string!, badgeDescription: subJson["description"].string!, icon: subJson["icon"].string!, totalPoints: subJson["total_points"].int!, price: subJson["price"].string!, priceLink: subJson["price_link"].string! ?? "None", priceEbook: subJson["price_ebook"].string! ?? "None")
                        self.rewards.append(reward)
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            self.collection!.reloadData()
                        })
                        
                    }
                case .Failure(let error):
                    print (error)
                }
                
        }
    }
    
    
    

}
