//
//  URLFormatextension.swift
//  HackerNews
//
//  Created by Trym Lintzen on 31-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//


extension String{
    func removeSpecialCharsFromString() -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)
        let tempString = (String(self.characters.filter {okayChars.contains($0) }))
        let urlString :String = tempString.replacingOccurrences(of: " ", with: "%20")
        print(urlString)
        return urlString
    }
}
