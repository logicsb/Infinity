//
//  SamplesTableViewController.swift
//  InfinitySample
//
//  Created by Danis on 15/12/22.
//  Copyright © 2015年 danis. All rights reserved.
//

import UIKit
import Infinity

class SamplesTableViewController: UITableViewController {

    var type = 0
    var items = 15
    /**
     *  automaticallyAdjustsScrollViewInsets 需要在addPullToRefresh和addInfinity之前设定好
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = true
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SampleCell")
        self.tableView.supportSpringBounces = true
        
        self.addPullToRefresh(type)
        self.addInfinityScroll(type)
        
        self.tableView.infinityStickToContent = true
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    deinit {
        self.tableView.removePullToRefresh()
        self.tableView.removeInfinityScroll()
    }
    
    func addPullToRefresh(type: Int) {
        switch type {
        case 0:
            let animator = DefaultRefreshAnimator(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            self.tableView.addPullToRefresh(animator: animator, action: { () -> Void in
                let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                    Int64(1.5 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    self.tableView?.endRefreshing()
                }
            })
        default:
            break
        }
    }
    func addInfinityScroll(type: Int) {
        switch type {
        case 0:
            let animator = DefaultInfinityAnimator(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            self.tableView.addInfinityScroll(animator: animator, action: { () -> Void in
                let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                    Int64(1.5 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    self.items += 15
                    self.tableView.reloadData()
                    self.tableView?.endInfinityScrolling()
                }
            })
            self.tableView.infinityStickToContent = true
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SampleCell", forIndexPath: indexPath)

        cell.textLabel?.text = "Cell"

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let newVC = UIViewController()
        newVC.view.backgroundColor = UIColor.redColor()
        
        self.showViewController(newVC, sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
