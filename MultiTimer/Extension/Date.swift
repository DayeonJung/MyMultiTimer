//
//  Date.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import Foundation

extension Date {
    func dateString() -> String{
        
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formatter.dateFormat = "MM월 dd일 HH:mm"
        
        return formatter.string(from: self)
    }
}
