//
//  TimerModel.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import Foundation

struct TimerListModel: Codable {
    var records: [TimerModel]
}

struct TimerModel: Codable {
    var name: String
    var times: Int = 0
    var secondsToFill: Int
}

