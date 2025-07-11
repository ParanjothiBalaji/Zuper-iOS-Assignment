//
//  DateFormatterHelper.swift
//  Zuper-iOS Assignment
//
//  Created by Paranjothi Balaji on 11/07/25.
//


import Foundation

struct DateFormatterHelper {
    
   static func smartDateFormat(from isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: isoDate) else {
            return "Invalid Date"
        }

        let calendar = Calendar.current
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"

        if calendar.isDateInToday(date) {
            return "Today, \(timeFormatter.string(from: date))"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow, \(timeFormatter.string(from: date))"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday, \(timeFormatter.string(from: date))"
        } else {
            let fullFormatter = DateFormatter()
            fullFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
            return fullFormatter.string(from: date)
        }
    }
}
