//
//  mainHackerViewController.swift
//  HackerNews
//
//  Created by Trym Lintzen on 31-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import Foundation
import UIKit

extension MainHackerTableViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("************************************",indexPath.row ,"  " ,hackerItemsObjects.count, " current page: ", currentPage)
        if indexPath.row == hackerItemsObjects.count - 1 {
            currentPage = currentPage + 1
            HackerNewsService.sharedInstance.getTheHackerNews(pages: currentPage, query: currentQuery)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hackerItemsObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIDs.shortTableViewCell, for: indexPath) as! shortTableViewCell
        
        let storeObject = hackerItemsObjects[indexPath.row]
        
        cell.titleLabel.text = storeObject.story_title
        //        cell.created_atLabel.text = storeObject.created_at
        cell.AuthorLabel.text = "\(storeObject.author) - \(convertToDate(epochTime: storeObject.created_at_i))"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Dit geeft aan dat welke row je klikt in de alle shoppingItemObject dat het de selectedShopping item wordt voor volgende "prepare" functie.
        self.selectedHackerItem = hackerItemsObjects[indexPath.row]
        
        performSegue(withIdentifier: seguesIdentifiers.detailViewSegue , sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            hackerItemsObjects.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
}
