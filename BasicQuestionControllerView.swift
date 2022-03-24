import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import SVProgressHUD

class BasicViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // Basic variables
    let basicQuestionURL = "https://pdimensions2016.herokuapp.com/api/questions/basic/"
    var basicQuestions = [Question]()
    var collection: UICollectionView?
    var indicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)

    override func viewDidLoad() {
        super.viewDidLoad()
         
        SVProgressHUD.show()
        // Get and download all basic questions data
        getBasicQuestion()
        
        // Layout collection view settings
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8.5, left: 0, bottom: 120.5, right: 0)
        self.collection = UICollectionView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), collectionViewLayout: layout)
        self.collection!.delegate = self
        self.collection!.dataSource = self
        self.collection!.registerClass(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(self.collection!)
        self.collection!.backgroundColor = UIColor(red: 206/255.0, green: 206/255.0, blue: 206/255.0, alpha: 1.0)
    }
    
    override func viewDidAppear(animated: Bool) {
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
    
    // Collection cell setup
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = .whiteColor()
        let url = basicQuestions[indexPath.row].normalImage
        let imageURL = NSURL(string: url)
        let imageData = NSData(contentsOfURL: imageURL!)
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
        let vc = BasicDetailViewController()
        vc.qTitle1 = String(basicQuestions[indexPath.row].title)
        let url = basicQuestions[indexPath.row].coverImage
        let imageURL = NSURL(string: url)
        let imageData = NSData(contentsOfURL: imageURL!)
        vc.coverImage1 = imageData!
        vc.qDescription = basicQuestions[indexPath.row].answerSet
        self.navigationController?.showViewController(vc, sender: self)
    }
    
    
    
    // Download data
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
                    SVProgressHUD.dismiss()
                    self.collection!.reloadData()                  
                case .Failure(let error):
                    print (error)
                }
            }
    }
}