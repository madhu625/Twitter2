//
//  TweetUserViewController.swift
//  Twitter1
//
//  Created by Deepti Chinta on 10/5/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit


class TweetUserViewController: UIViewController {
    var currentUser: User?

    @IBOutlet weak var TweetUserName: UILabel!
    @IBOutlet weak var TweetUserImage: UIImageView!
    @IBOutlet weak var TweetScreenName: UILabel!
    @IBOutlet weak var TweetUserTag: UILabel!
    @IBOutlet weak var TweetCount: UILabel!
    @IBOutlet weak var FollowingCount: UILabel!
    @IBOutlet weak var FriendsCount: UILabel!
    @IBOutlet weak var TweetHeaderImage: UIImageView!

    @IBAction func onHome(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.52, green:0.76, blue:1.00, alpha:0.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        if currentUser == nil {
            currentUser = User.currentUser
        }

        self.TweetUserName.text = currentUser!.name
        self.TweetUserTag.text = currentUser!.tagline
        self.TweetScreenName.text = "@" + currentUser!.screenname! as String
        self.TweetUserImage.setImageWithURL(NSURL(string: currentUser!.profileImageUrl!))
        self.TweetCount.text = String(currentUser!.tweetCount!)
        self.FollowingCount.text = String(currentUser!.followersCount!)
        self.FriendsCount.text = String(currentUser!.friendsCount!)
        self.TweetHeaderImage.setImageWithURL(NSURL(string: currentUser!.bannerImageURL!))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
