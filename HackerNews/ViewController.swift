//
//  ViewController.swift
//  HackerNews
//
//  Created by Trym Lintzen on 27-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
   
    var selectedHackerItem: HackerNewsProperties?
    
    @IBOutlet weak var webViewOutlet: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HackerNewsService.sharedInstance.getTheHackerNews()
   
            let storyURL =  selectedHackerItem?.story_url ?? ""
            webViewOutlet.loadRequest(URLRequest(url: NSURL(string: "\(String(describing: storyURL))")! as URL))
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

