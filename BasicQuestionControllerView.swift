import UIKit
import Alamofire
import SwiftyJSON

class BasicViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let basicQuestionURL = "https://dimensions2016.herokuapp.com/api/questions/basic"
    
    var basicQuestions = [Question]()
    
    var collection: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        getBasicQuestion()
        
        
        dispatch_async(dispatch_get_main_queue(), {
            self.collection!.reloadData()
        })
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // layout.itemSize = CGSize(width: self.view.frame.width/3.0 - 10, height: self.view.frame.width/3.0 - 10)
        
        
        
        self.collection = UICollectionView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), collectionViewLayout: layout)
        
        self.collection!.delegate = self
        self.collection!.dataSource = self
        self.collection!.registerClass(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(self.collection!)
        
        self.collection!.backgroundColor = UIColor(red: 206/255.0, green: 206/255.0, blue: 206/255.0, alpha: 1.0)
        
        //self.collection!.backgroundColor = .redColor()
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        
        cell.backgroundColor = .whiteColor()
        
        var url = basicQuestions[indexPath.row].coverImage
        var imageURL = NSURL(string: url)
        var imageData = NSData(contentsOfURL: imageURL!)
        
        
        cell.imageView.image = UIImage(data: imageData!)
        cell.title.text = basicQuestions[indexPath.row].title
        
        cell.aCounts.text = String("\(basicQuestions[indexPath.row].answerSet.count) answers")
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.basicQuestions.count
    }
    
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section : Int) -> CGFloat {
        return 10.5
    }
    
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section : Int) -> CGFloat {
        return 8.5
    }
    
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width-20, height: 200)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        let vc = BasicDetailViewController()
        vc.qTitle1 = String(basicQuestions[indexPath.row].title)
        var url = basicQuestions[indexPath.row].coverImage
        var imageURL = NSURL(string: url)
        var imageData = NSData(contentsOfURL: imageURL!)
        vc.coverImage1 = imageData!
        print(vc.coverImage1)
        vc.qDescription = basicQuestions[indexPath.row].answerSet
        
        
        self.navigationController?.showViewController(vc, sender: self)
    }
    
    
    
    func getBasicQuestion() {
        Alamofire.request(.GET, self.basicQuestionURL)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let basicData = JSON(response.result.value!)
                    
                    for (index, subJson) : (String, JSON) in basicData {
                        let basicQuestion = Question(id : subJson["id"].int!, title : subJson["title"].string!, proTip : subJson["pro_tip"].string!, coverImage : subJson["cover_image"].string!, normalImage : subJson["normal_image"].string!)
                        
                        basicQuestion.answerSet = subJson["answer_set"].array!
                        self.basicQuestions.append(basicQuestion)
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.collection!.reloadData()
                    })
                    
                    
                    
                    
                case .Failure(let error):
                    print (error)
                }
                
        }
        
    }
    
}