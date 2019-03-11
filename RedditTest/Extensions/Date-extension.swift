//
//  Date-extension.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import Foundation

extension Date {
    func timeAgoSinceDate(numericDates:Bool) -> String? {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components:DateComponents = (calendar as NSCalendar).components([.minute , .hour , .day , .weekOfYear , .month , .year , .second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if let year = components.year, year >= 1 {
            if year >= 2 {
                return "\(year) years ago"
            } else  if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if let month = components.month, month >= 1 {
            if month >= 2 {
                return "\(month) months ago"
            } else  if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if let weekOfYear = components.weekOfYear, weekOfYear >= 1 {
            if weekOfYear >= 2 {
                return "\(weekOfYear) weeks ago"
            } else if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if let day = components.day, day >= 1 {
            if day >= 2 {
                return "\(day) days ago"
            } else if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if let hour = components.hour, hour >= 1 {
            if hour >= 2 {
                return "\(hour) hours ago"
            } else if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if let minute = components.minute, minute >= 1 {
            if minute >= 2 {
                return "\(minute) minutes ago"
            } else if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if let second = components.second {
            if second >= 3 {
                return "\(second) seconds ago"
            } else {
                return "Just now"
            }
        }
        
        return nil
    }
}
