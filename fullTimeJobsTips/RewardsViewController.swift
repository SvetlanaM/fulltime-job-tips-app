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
import SVProgressHUD

class RewardsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // Basic variables
    var rewardsURL = "https://pdimensions2016.herokuapp.com/api/rewards/"
    var rewards = [Reward]()
    var collection: UICollectionView?
    var rewardsIcons = [Int : String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        

        rewardsIcons[3] = "impressed"
        rewardsIcons[2] = "not-sure-about-you"
        rewardsIcons[1] = "sad"
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8.5, left: 0, bottom: 20.5, right: 0)
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
        if imageData != nil {
            cell.iconView.image = UIImage(data: imageData!)
        }
        else {
            cell.iconView.image = UIImage(named: rewards[indexPath.row].icon)
        }
        
        
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let urlString = rewards[indexPath.row].priceEbook
        let url = NSURL(string: urlString)
        print (url)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    override func viewDidAppear(animated: Bool) {
        getRewards()
        self.navigationController?.navigationBarHidden = false
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        self.tabBarController?.tabBar.hidden = false
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        self.tabBarController?.tabBar.hidden = false
    }
    
    

    func getRewards() {
        self.rewards = []
        Alamofire.request(.GET, self.rewardsURL)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let rewardsData = JSON(response.result.value!)
                    for (index, subJson) : (String, JSON) in rewardsData {
                        let reward = Reward(id: subJson["id"].int!, title: subJson["title"].string!, badgeDescription: subJson["description"].string!, icon: subJson["icon"].string!, totalPoints: subJson["total_points"].int!, price: subJson["price"].string!)
                        self.rewards.append(reward)
                        
                        
                        for item in self.rewards {
                            let defaults = NSUserDefaults.standardUserDefaults()
                            let token = defaults.integerForKey("Points")
                            if token >= 30 && item.totalPoints == 30 {
                                print ("true")
                                item.changeIcon("sad-blue")
                                let index = self.rewards.indexOf(item)
                                let link = String(rewardsData[index!]["price_link"])
                                item.setThePriceEbook(link)
                            }
                            else if token >= 60 && item.totalPoints == 60 {
                                item.changeIcon("not-sure-blue")
                                let index = self.rewards.indexOf(item)
                                let link = String(rewardsData[index!]["price_link"])
                                item.setThePriceEbook(link)
                            }
                            else if token >= 90 && item.totalPoints == 90 {
                                item.changeIcon("impressed-blue")
                                let index = self.rewards.indexOf(item)
                                let link = String(rewardsData[index!]["price_link"])
                                item.setThePriceEbook(link)
                            }

                        }
                        
                        SVProgressHUD.dismiss()
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
