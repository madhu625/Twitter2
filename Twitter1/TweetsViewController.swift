//
//  TweetsViewController.swift
//  Twitter1
//
//  Created by Deepti Chinta on 9/27/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource {
    var tweets: [Tweet]?
    let CELL_NAME = "TwitterCell"
    var refreshControl = UIRefreshControl()


    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = tweets {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME) as! TwitterCell
        
        let thisTweet = tweets![indexPath.row] as Tweet
        let thisUser = thisTweet.user! as User
        cell.TweetLabel.text = thisTweet.text! as String
        cell.NameLabel.text = thisUser.name! as String
        cell.ProfileImage.setImageWithURL(NSURL(string: thisUser.profileImageUrl!))
        cell.TagLabel.text = "@" + thisUser.screenname! as String
        cell.HourLabel.text = thisTweet.time!
        /*
        let url = NSURL(string: thisUser.profileImageUrl!)
        if let data = NSData(contentsOfURL: url!){
          //  imageURL.contentMode = UIViewContentMode.ScaleAspectFit

            var imageData = UIImage(data: data)!
            print (imageData)
            cell.ImageButton.setImage(imageData, forState: .Normal)
        }
        */
        
        cell.ProfileImage.tag = indexPath.row

        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onImageTap:")
        
        // var location = tapGestureRecognizer.locationInView(self.trayView)
        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 1;
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        cell.ProfileImage.userInteractionEnabled = true
        cell.ProfileImage.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }

    
    
    func onImageTap(tapGestureRecognizer: UITapGestureRecognizer) {

       // var point = tapGestureRecognizer.locationInView(view)
        print ("Image tapped here")
        //goToProfile(self.)
         print (tapGestureRecognizer.view?.tag)

        performSegueWithIdentifier("imageSegue", sender: tapGestureRecognizer.view?.tag)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //CAE5FF
        self.navigationController!.navigationBar.barTintColor = UIColor(red:0.52, green:0.76, blue:1.00, alpha:0.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Do any additional setup after loading the view.
        self.refreshControl = UIRefreshControl()

        
        refreshControl.addTarget(self, action: "fetchTweets", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl, atIndex: 0)
        self.fetchTweets()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func fetchTweets() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets,error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print(segue.identifier)
        if (segue.identifier == "detailsSegue"){
            let cell = sender as! TwitterCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = self.tweets![indexPath!.row]
            let detailsViewController = segue.destinationViewController as! DetailsViewController
            
            print(detailsViewController)
            
            detailsViewController.currentTweet = tweet
            
            
            
        } else if (segue.identifier == "imageSegue") {
            let user = self.tweets![sender as! Int].user
            print (user)
            let tweetUserViewController = segue.destinationViewController as! TweetUserViewController
            tweetUserViewController.currentUser = user

            
        } else
        
        {
                    }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}


class TwitterCell:UITableViewCell{

    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var TweetLabel: UILabel!
    @IBOutlet weak var HourLabel: UILabel!
    @IBOutlet weak var TagLabel: UILabel!
    
    
}


