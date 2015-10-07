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
    var tweetUserViewController: TweetUserViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("inHamburger ViewController")

        // Do any additional setup after loading the view.

        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TweetsNavigationController") as! UINavigationController

        feedView = navController.view
        view.addSubview(feedView)
        view.bringSubviewToFront(feedView)

        addChildViewController(navController)
        navController.didMoveToParentViewController(self)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        view.addGestureRecognizer(panGestureRecognizer)

    }
    
    override func viewDidAppear(animated: Bool) {
        print ("Hamburger viewDidAppear")
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
      //  var translation = panGestureRecognizer.translationInView(self.view)
      //  var point = panGestureRecognizer.locationInView(self.view)
        let velocity = panGestureRecognizer.velocityInView(self.view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            if (velocity.x > 0){
                print ("Right")
                let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
                navController.delegate=self
                menuView = navController.view
                menuView.frame = CGRectMake(0, 0, 270, 568)
                view.addSubview(menuView)
                //view.bringSubviewToFront(feedView)
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

    func loadLeftNav(vcstring: String){
        print ("Right")
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(vcstring) as! UINavigationController
        feedView = navController.view
        view.addSubview(feedView)
        view.bringSubviewToFront(feedView)
        addChildViewController(navController)
        navController.didMoveToParentViewController(self)
    }
    
    func loadLeftView(vcstring: String){
        print ("Right")
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(vcstring) as! UIViewController
        feedView = navController.view
        view.addSubview(feedView)
        view.bringSubviewToFront(feedView)
        addChildViewController(navController)
        navController.didMoveToParentViewController(self)
    }
    
    
    //let menuItems: NSArray = ["Profile", "Home", "Mentions", "Log Out"]
    func cellSelected(menuItem: NSString){
        print("\(menuItem)")
        switch(menuItem){
        case "Profile":
            print ("profile here hurrayy")
            loadLeftView("TweetUserViewController")

        case "Home":
            print ("home here hurray")
            loadLeftNav("TweetsNavigationController")
           // let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TweetsNavigationController") as! UINavigationController
            
           // self.presentViewController(navController, animated: true, completion: nil)

        case "Mentions":
            print ("mentions here hurray")
        case "Log Out":
            User.currentUser?.logout()
        default:
            print ("no entry hurray")
        }
    }


}
