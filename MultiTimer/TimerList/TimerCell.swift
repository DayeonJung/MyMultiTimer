//
//  TimerCell.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/02.
//

import UIKit

class TimerCell: UITableViewCell {

    @IBOutlet weak var startPauseButton: TitleButton!
    @IBOutlet weak var resetButton: TitleButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    
    var timer = Timer()
    var currentTime: Int = 0 {
        didSet {
            self.timeDidChange()
        }
    }
    var startTime: Date? = nil {
        didSet {
            self.saveStartTime()
            let message = self.startTime?.dateString() == nil ? nil : (self.startTime!.dateString() + "에 시작했어요.")
            self.startTimeLabel.text = message
        }
    }
    
    var saved: TimerListModel? {
        get {
            UserDefaultManager.getValue(with: .timerInfo)
        }
        set {
            UserDefaultManager.setValue(with: newValue, key: .timerInfo)
        }
        
    }
    
    var currentState: TimerState = .pause
    var model: TimerModel?
    
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
        
        self.backgroundColor = .white
        
        self.startTimeLabel.text = ""
        
        self.startPauseButton.onClick = {
            self.changeState()
        }
        
        self.resetButton.onClick = {
            self.currentTime = 0
            self.startTime = self.currentState == .play ? Date() : nil
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
            
            if self.startTime == nil {
                self.startTime = Date()
            }
        }
        
        self.startPauseButton.setTitle(self.currentState.rawValue, for: .normal)
        self.currentState = self.currentState.stateToChange
        
    }
    
    @objc private func timeIsGoing() {
        self.currentTime += 1
    }
    
    func timeDidChange() {
        self.timeLabel.text = self.currentTime.hourMinuteSecond()
        self.saveCurrentTime()
        
    }
    
    private func saveStartTime() {
        guard let index = self.findIndexOfRecords() else { return }
        self.saved?.records[index].startTime = self.startTime
    }
    
    private func saveCurrentTime() {
        guard let index = self.findIndexOfRecords() else { return }
        self.saved?.records[index].times = self.currentTime
    }
    
    private func findIndexOfRecords() -> Int? {
        guard let timerModel = self.model else { return nil }
        return self.saved?.records.firstIndex(where: {$0.name == timerModel.name })
    }
    
    func setUI(with model: TimerModel) {
        self.model = model
        self.nameLabel.text = model.name
        self.currentTime = model.times
        self.startTime = model.startTime
    }
    

    
}
