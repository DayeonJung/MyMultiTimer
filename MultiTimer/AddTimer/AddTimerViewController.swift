//
//  AddTimerViewController.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import UIKit

protocol AddTimerProtocol: AnyObject {
    func addTimerDidFinish()
}

class AddTimerViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timesTextField: UITextField!
    @IBOutlet weak var addButton: TitleButton!
    
    var savedTimers: TimerListModel = UserDefaultManager.getValue(with: .timerInfo) ?? TimerListModel(records: [])
    
    var availablePeriods: [Int] = [60, 70]
    var selectedPeriodIndex: Int?
        
    weak var delegate: AddTimerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createPickerView()
        dismissPickerView()
        setAddButtonEvent()
    }
    
    private func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        timesTextField.inputView = pickerView
    }
    
    private func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.setTextField))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        timesTextField.inputAccessoryView = toolBar
    }
    
    @objc func setTextField() {
        timesTextField.resignFirstResponder()
    }
    
    private func setAddButtonEvent() {
        self.addButton.onClick = {
            
            guard let name = self.nameTextField.text else {
                self.showAlert(with: "이름을 입력해주세요")
                return
            }
            
            guard self.savedTimers.records.contains(where: {$0.name == name}) == false else {
                self.showAlert(with: "이미 등록되어 있는 이름이예요")
                return
            }
            
            guard let selectedPeriodIdx = self.selectedPeriodIndex else {
                self.showAlert(with: "시간을 선택해주세요")
                return
            }
            
            let timesToSeconds = self.availablePeriods[selectedPeriodIdx] * 60
            let timerModel = TimerModel(name: name, secondsToFill: timesToSeconds)
            var savedRecords = self.savedTimers.records
            savedRecords.append(timerModel)
            self.savedTimers.records = savedRecords
            UserDefaultManager.setValue(with: self.savedTimers, key: .timerInfo)
            self.dismiss(animated: true, completion: {
                self.delegate?.addTimerDidFinish()
            })
        }
    }
    
    func showAlert(with message: String) {
        let alertView = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "확인", style: .default, handler: { action in
            alertView.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertView, animated: true, completion: nil)
    }
}

extension AddTimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.availablePeriods.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.availablePeriods[row].koreanUnitFromMinutes()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedPeriodIndex = row
        timesTextField.text = self.availablePeriods[row].koreanUnitFromMinutes()
    }
    
}
