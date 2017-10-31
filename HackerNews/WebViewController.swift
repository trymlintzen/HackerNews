//
//  ViewController.swift
//  HackerNews
//
//  Created by Trym Lintzen on 27-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate ,WKNavigationDelegate {
    
   
    var selectedHackerItem: HackerNewsProperties?
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
//    @IBOutlet weak var webViewOutlet: WKWebView!
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyURL =  selectedHackerItem?.story_url ?? ""
//        webView.delegate = self
        print(storyURL)
        if let url = URL(string: storyURL) {
            let request = URLRequest.init(url: url)
//            webView.loadRequest(request)
            webView.load(request)
        }
        
        
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideActivityIndicator(loadingView: loadingView, spinner: spinner)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         self.showActivityIndicator(loadingView: loadingView, spinner: spinner)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    private func webViewDidStartLoad(_ webView: WKWebView) {
//        self.showActivityIndicator(loadingView: loadingView, spinner: spinner)
//    }
//
//    private func webViewDidFinishLoad(_ webView: WKWebView) {
//          self.hideActivityIndicator(loadingView: loadingView, spinner: spinner)
//    }
    
    


//    func showActivityIndicator() {
//        DispatchQueue.main.async() {
//            self.loadingView = UIView()
//            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
//            self.loadingView.center = self.view.center
//            self.loadingView.backgroundColor = UIColor.black
////                UIColor(rgba: "#444444")
//            self.loadingView.alpha = 1
//            self.loadingView.clipsToBounds = true
//            self.loadingView.layer.cornerRadius = 10
//
//            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
//            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
//            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
//
//            self.loadingView.addSubview(self.spinner)
//            self.view.addSubview(self.loadingView)
//            self.spinner.startAnimating()
//        }
//    }
//
//    func hideActivityIndicator() {
//        DispatchQueue.main.async() {
//            self.spinner.stopAnimating()
//            self.loadingView.removeFromSuperview()
//        }
//    }
    
}

