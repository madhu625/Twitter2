//
//  HamburgerViewController.swift
//  Twitter1
//
//  Created by Deepti Chinta on 10/4/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController, MenuViewControllerDelegate {

    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var feedView: UIView!
    
    var menuViewController: MenuViewController!
    var feedViewController: UINavigationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("inHamburger ViewController")

        // Do any additional setup after loading the view.
        
        var navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TweetsNavigationController") as! UINavigationController
        
        feedView = navController.view
        view.addSubview(feedView)
        view.bringSubviewToFront(feedView)
        
        addChildViewController(navController)
        navController.didMoveToParentViewController(self)

        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        view.addGestureRecognizer(panGestureRecognizer)
        
       /*
        let storyboard = UIStoryboard(name: "MenuViewController", bundle: nil)
        let secondVC = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        secondVC.delegate = self
        presentViewController(secondVC, animated: true, completion: nil)
        */
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print ("viewDidAppear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        var translation = panGestureRecognizer.translationInView(self.view)
        var point = panGestureRecognizer.locationInView(self.view)
        var velocity = panGestureRecognizer.velocityInView(self.view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            if (velocity.x > 0){
                print ("Right")
                let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
                menuView = navController.view
                menuView.frame = CGRectMake(0, 0, 270, 568)
                
                view.addSubview(menuView)

                //  view.bringSubviewToFront(feedView)
                 addChildViewController(navController)
                 navController.didMoveToParentViewController(self)
            } else {
                print ("Left")
                let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TweetsNavigationController") as! UINavigationController
                feedView = navController.view
                view.addSubview(feedView)
                view.bringSubviewToFront(feedView)
                addChildViewController(navController)
                navController.didMoveToParentViewController(self)
            }
        }
    }

    
    //   let menuItems: NSArray = ["Profile", "Home", "Mentions"]
    func cellSelected(menuItem: NSString){
        print("\(menuItem)")
        switch(menuItem){
        case "Profile":
            print ("profile here")
            //let profileVCtypecast = profileViewController as ProfileViewController
            //profileVCtypecast.user = User.currentUser
            //setCenterNavigationController(profileViewController)
            
            //timelineViewController.navItem.title = "Timeline"
            //timelineViewController.loadTweets()
            //setCenterNavigationController(timelineViewController)
        case "Home":
            print ("home here")

            //timelineViewController.navItem.title = "Home"
            //timelineViewController.loadTweets()
            //setCenterNavigationController(timelineViewController)
        case "Mentions":
            print ("mentions here")

            //setCenterNavigationController(composerViewController)
      //  case "Log Out":
            //User.currentUser?.logout()
        default:
            print ("no entry")

        }
    }


}
