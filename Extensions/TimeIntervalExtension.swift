//
//  TimeIntervalExtension.swift
//  HackerNews
//
//  Created by Trym Lintzen on 30-10-17.
//  Copyright © 2017 Trym. All rights reserved.
//

import Foundation
import UIKit

extension TimeInterval {
    
    func convertToDate() -> String{
        
        let currentSince1970 = Date().timeIntervalSince1970
        //        let currentSince1970 = currentDate.timeIntervalSince1970
        let differenceDate = ((currentSince1970 - self) / 60)
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
}
