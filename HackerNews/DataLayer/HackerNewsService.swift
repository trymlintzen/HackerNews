//
//  HackerNewsService.swift
//  HackerNews
//
//  Created by Trym Lintzen on 27-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import Foundation
import Alamofire

class HackerNewsService {
    public static let sharedInstance = HackerNewsService()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    
    private init() { // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    }
    
    func getTheHackerNews()  {
        var hackerItems: [HackerNewsProperties] = []
        
        Alamofire.request("https://hn.algolia.com/api/v1/search_by_date?query=ios",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default).responseJSON { (jsonData) in
                            print(jsonData)
            
                                if let result = jsonData.result.value as? NSDictionary {
                                    if let hits = result["hits"] as? NSArray {
                                        for currentHit in hits {
                                            if let dict = currentHit as? NSDictionary,
                                                let storyTitle = dict["story_title"] as? String,
                                                let author = dict["author"] as? String,
                                                let created_at_i = dict["created_at_i"] as? Int,
                                                let story_url = dict["story_url"] as? String {
                                                let hitObject = HackerNewsProperties.init(story_title: storyTitle, author: author, created_at_i: created_at_i, story_url: story_url)
                                                    hackerItems.append(hitObject)
                                                }
                                        }
                                    }
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationIDs.hackerItemID),
                                                                      object: self,
                                                                      userInfo: [dictKey.hackerItemKey : hackerItems])
                                }
        }
    }
    
    
    
}
