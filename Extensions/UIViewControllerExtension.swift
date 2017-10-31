//
//  UIViewExtension.swift
//  HackerNews
//
//  Created by Trym Lintzen on 31-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
//    var spinner: UIActivityIndicatorView {
//        get {
//            return UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
//        }
//    }
//    var loadingView: UIView {
//        get {
//            return UIView()
//        }
//    }
    func showActivityIndicator(loadingView: UIView, spinner: UIActivityIndicatorView) {
        
        DispatchQueue.main.async() {
            loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            loadingView.center = self.view.center
            loadingView.backgroundColor = UIColor.lightGray
            //                UIColor(rgba: "#444444")
            loadingView.alpha = 0.7
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            
            spinner.frame = CGRect(x: 0.0, y: 0.0, width: 70.0, height: 70.0)
            spinner.center = CGPoint(x:loadingView.bounds.size.width / 2, y:loadingView.bounds.size.height / 2)
            
            loadingView.addSubview(spinner)
            self.view.addSubview(loadingView)
            spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator(loadingView: UIView, spinner: UIActivityIndicatorView) {
        DispatchQueue.main.async() {
            spinner.stopAnimating()
            loadingView.removeFromSuperview()
        }
    }
}