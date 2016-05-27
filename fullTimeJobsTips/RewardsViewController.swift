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
    var rewardsIcons = [Int : String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        rewardsIcons[1] = "happy"
        rewardsIcons[2] = "impressed"
        rewardsIcons[3] = "not-happy"
        rewardsIcons[4] = "not-sure-about-you"
        rewardsIcons[5] = "sad"
        
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
                            if token >= 9 && item.totalPoints == 9 {
                                item.changeIcon("sad-blue")
                                let index = self.rewards.indexOf(item)
                                let link = String(rewardsData[index!]["price_ebook"])
                                item.setThePriceEbook(link)
                            }
                            else if token >= 50 && item.totalPoints == 50 {
                                item.changeIcon("not-happy-blue")
                                let index = self.rewards.indexOf(item)
                                let link = String(rewardsData[index!]["price_ebook"])
                                item.setThePriceEbook(link)
                            }
                            else if token >= 80 && item.totalPoints == 80 {
                                item.changeIcon("not-sure-blue")
                                let index = self.rewards.indexOf(item)
                                let link = String(rewardsData[index!]["price_ebook"])
                                item.setThePriceEbook(link)
                            }
                            else if token >= 120 && item.totalPoints == 120 {
                                item.changeIcon("happy-blue")
                                let index = self.rewards.indexOf(item)
                                let link = String(rewardsData[index!]["price_ebook"])
                                item.setThePriceEbook(link)
                            }
                            else if token >= 180 && item.totalPoints == 180 {
                                item.changeIcon("impressed-blue")
                                let index = self.rewards.indexOf(item)
                                let link = String(rewardsData[index!]["price_ebook"])
                                item.setThePriceEbook(link)
                            }

                        }
                        
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
