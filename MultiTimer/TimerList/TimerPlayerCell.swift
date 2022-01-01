//
//  TimerPlayerCell.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import UIKit

class TimerPlayerCell: UICollectionViewCell {

    @IBOutlet weak var startPauseButton: TitleButton!
    @IBOutlet weak var resetButton: TitleButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var finishTimeLabel: UILabel!
    
    var timer = Timer()
    var currentTime: Int = 0 {
        didSet {
            self.timeDidChange()
        }
    }
    var currentState: TimerState = .pause
    
    enum TimerState: String {
        case play = "시작"
        case pause = "중지"
        case reset = "초기화"
        
        var stateToChange: Self {
            if self == .play {
                return .pause
            } else if self == .pause {
                return .play
            }
            return .reset
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.startTimeLabel.text = ""
        self.finishTimeLabel.text = ""
        
        self.startPauseButton.onClick = {
            self.changeState()
        }
        
        self.resetButton.onClick = {
            self.currentTime = 0
        }
    }

    private func changeState() {
        
        if self.currentState == .play {
            self.timer.invalidate()
            
        } else if self.currentState == .pause {
            self.timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(timeIsGoing),
                userInfo: nil,
                repeats: true
            )
        }
        
        self.startPauseButton.setTitle(self.currentState.rawValue, for: .normal)
        self.currentState = self.currentState.stateToChange
        
    }
    
    @objc private func timeIsGoing() {
        self.currentTime += 1
    }
    
    func timeDidChange() {
        self.timeLabel.text = self.currentTime.hourMinuteSecond()
    }
    
}
