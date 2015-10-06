//
//  MenuViewController.swift
//  Twitter1
//
//  Created by Deepti Chinta on 10/4/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    func cellSelected(menuItem: NSString)
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTag: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    var delegate: MenuViewControllerDelegate?
    

    
    let menuItems: NSArray = ["Profile", "Home", "Mentions"]

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as! MenuCell
        cell.menuLabel.text = menuItems[indexPath.row] as! NSString as String
        return cell
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print ("cell deselected")
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("inside didSelectRowAtIndexPath")
        //cellSelected(menuItems[indexPath.row] as! NSString)
        delegate?.cellSelected(menuItems[indexPath.row] as! NSString)
        
        
        print(menuItems[indexPath.row])
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.text = User.currentUser!.name
        self.userImage.setImageWithURL(NSURL(string: User.currentUser!.profileImageUrl!))
        self.userTag.text = "@" + User.currentUser!.screenname! as String
        menuTableView.delegate = self

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


class MenuCell:UITableViewCell{
    
    @IBOutlet weak var menuLabel: UILabel!
}


