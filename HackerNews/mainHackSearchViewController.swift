//
//  mainHackerSearchViewController.swift
//  HackerNews
//
//  Created by Trym Lintzen on 31-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import Foundation
import UIKit

extension MainHackerTableViewController: UISearchBarDelegate {
    
    func setUPSearchBar () {
        self.searchController = UISearchController.init(searchResultsController: nil)
        self.searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = false
        
        // add search bar to navigation title
        navigationItem.titleView = searchController?.searchBar
        
        
    }
    
    //    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    //
    //    }
    //
    
    func isMoreThanTwoCharacter(_ searchBar: UISearchBar) -> Bool {
        return (searchBar.text?.characters.count)! >= 4
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isMoreThanTwoCharacter(searchBar) {
            self.hackerItemsObjects = []
            HackerNewsService.sharedInstance.getTheHackerNews(pages: 0, query: searchBar.text!.removeSpecialCharsFromString())
            self.showActivityIndicator(loadingView: loadingView, spinner: spinner)
        }
    }
    
}
