//
//  Int.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import Foundation

extension Int {
    enum DateComponent {
        case hour
        case minute
        case second
    }
    
    func hourMinuteSecond() -> String {
        
        var restSeconds = self
        let hourUnitFromSeconds = 60 * 60
        let hours = restSeconds / hourUnitFromSeconds
        restSeconds = restSeconds % hourUnitFromSeconds
        
        let minuteUnitFromSeconds = 60
        let minutes = restSeconds / minuteUnitFromSeconds
        restSeconds = restSeconds % minuteUnitFromSeconds
        
        return hours.twoLengthString(compo: .hour) + minutes.twoLengthString(compo: .minute) + restSeconds.twoLengthString(compo: .second)
    }
    
    func twoLengthString(compo: DateComponent) -> String {
        
        var result = ""
        
        if self == 0 {
            result = "00"
        } else if self < 10 {
            result = "0\(self)"
        } else {
            result = "\(self)"
        }
        
        if compo == .hour, self == 0 {
            return ""
        }
        if compo != .second {
            result += ":"
        }
        return result
        
    }
    
}
