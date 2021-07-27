//
//  Date+TimeAgo.swift
//  RedditDemo
//
//  Created by Santos Ramon on 7/27/21.
//

import Foundation

extension Date {
    func timeAgo() -> String {
        let created = self.timeIntervalSince1970
        let currentTime = Date.init()
        let timeAgo = Int(currentTime.timeIntervalSince1970) - Int(created)
        let hours = timeAgo / 3600
        return "\(hours) hours ago"
    }
}
