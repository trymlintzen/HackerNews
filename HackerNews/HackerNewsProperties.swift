//
//  HackerNewsProperties.swift
//  HackerNews
//
//  Created by Trym Lintzen on 27-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import Foundation

class HackerNewsProperties {
    
    var story_title: String
    var author: String
    var created_at_i : Int
    var story_url: String
  
    init(story_title: String, author: String, created_at_i: Int, story_url: String) {
        self.story_title = story_title
        self.author = author
        self.created_at_i = created_at_i
        self.story_url = story_url
    }
    

}
