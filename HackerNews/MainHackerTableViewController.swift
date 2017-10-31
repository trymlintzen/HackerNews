//
//  MainHackerTableViewController.swift
//  HackerNews
//
//  Created by Trym Lintzen on 27-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import UIKit

class MainHackerTableViewController: UITableViewController, UISearchBarDelegate {
    
    var hackerItemsObjects: [HackerNewsProperties] = []
    var selectedHackerItem: HackerNewsProperties?
    var refresh: UIRefreshControl!
    var currentPage = 0
    var currentQuery = "ios"
 
    
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
        
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @objc func refreshing(_ sender: Any) {
        HackerNewsService.sharedInstance.getTheHackerNews(pages: 0, query: currentQuery)
//        self.hackerItemsObjects = []

    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("************************************",indexPath.row ,"  " ,hackerItemsObjects.count, " current page: ", currentPage)
        if indexPath.row == hackerItemsObjects.count - 1 {
            currentPage = currentPage + 1
            HackerNewsService.sharedInstance.getTheHackerNews(pages: currentPage, query: currentQuery)
        }
    }

    @objc func notifyObservers(notification: NSNotification) {

        var HackerItemDict = notification.userInfo as! Dictionary<String , [HackerNewsProperties]>
        hackerItemsObjects += HackerItemDict[dictKey.hackerItemKey]!
        self.tableView.reloadData()
        
        refresh.endRefreshing()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hackerItemsObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIDs.shortTableViewCell, for: indexPath) as! shortTableViewCell
        
        let storeObject = hackerItemsObjects[indexPath.row]
        
        cell.titleLabel.text = storeObject.story_title
//        cell.created_atLabel.text = storeObject.created_at
        cell.AuthorLabel.text = "\(storeObject.author) - \(convertToDate(epochTime: storeObject.created_at_i))"

        
        return cell
    }
    
    func convertToDate(epochTime: Int) -> String{
     
        let itemDate = TimeInterval(epochTime)
        let currentSince1970 = Date().timeIntervalSince1970
//        let currentSince1970 = currentDate.timeIntervalSince1970
        let differenceDate = ((currentSince1970 - itemDate) / 60)
        var result = ""
        if differenceDate > 60 {
            let minutes = differenceDate.truncatingRemainder(dividingBy: 60)
            let hours = String(format: "%.0f", (differenceDate / 60))
            let mins = String(format: "%.0f", minutes)
            result.append("\(hours)h \(mins)m")
        } else {
             let mins = String(format: "%.0f", differenceDate)
             result.append("\(mins)m")
        }
        return String(result)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Dit geeft aan dat welke row je klikt in de alle shoppingItemObject dat het de selectedShopping item wordt voor volgende "prepare" functie.
        self.selectedHackerItem = hackerItemsObjects[indexPath.row]
        
        performSegue(withIdentifier: seguesIdentifiers.detailViewSegue , sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seguesIdentifiers.detailViewSegue {
            
            // Hier zeg je dus: Ga naar "detail(View/Table)Segue" als op een selectedShoppingItem wordt geklikt, want check regel 82
            let detailView = segue.destination as! WebViewController
            detailView.selectedHackerItem = self.selectedHackerItem
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
        
            hackerItemsObjects.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
