//
//  MainHackerTableViewController.swift
//  HackerNews
//
//  Created by Trym Lintzen on 27-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import UIKit

class MainHackerTableViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    var hackerItemsObjects: [HackerNewsProperties] = []
    var selectedHackerItem: HackerNewsProperties?
    var refresh: UIRefreshControl!
    var currentPage = 0
    var currentQuery = "ios"
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MainHackerTableViewController.notifyObservers(notification:)),
                                               name: NSNotification.Name(rawValue: notificationIDs.hackerItemID),
                                               object: nil)
        
        
        let hackerNib = UINib(nibName: "shortTableViewCell", bundle: nil)
        self.tableView.register(hackerNib, forCellReuseIdentifier: TableCellIDs.shortTableViewCell)
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(refreshing), for: .valueChanged)
        self.tableView.addSubview(refresh!)
        HackerNewsService.sharedInstance.getTheHackerNews(pages: 0, query: currentQuery)
        
        setUPSearchBar()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    @objc func refreshing(_ sender: Any) {
        HackerNewsService.sharedInstance.getTheHackerNews(pages: 0, query: currentQuery)
        //        self.hackerItemsObjects = []
        
    }
    
    @objc func notifyObservers(notification: NSNotification) {
        
        var HackerItemDict = notification.userInfo as! Dictionary<String , [HackerNewsProperties]>
        hackerItemsObjects += HackerItemDict[dictKey.hackerItemKey]!
        self.tableView.reloadData()
        refresh.endRefreshing()
        self.hideActivityIndicator(loadingView: loadingView, spinner: spinner)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seguesIdentifiers.detailViewSegue {
            
            // Hier zeg je dus: Ga naar "detail(View/Table)Segue" als op een selectedShoppingItem wordt geklikt, want check regel 82
            let detailView = segue.destination as! WebViewController
            detailView.selectedHackerItem = self.selectedHackerItem
        }
    }
    
    
}
