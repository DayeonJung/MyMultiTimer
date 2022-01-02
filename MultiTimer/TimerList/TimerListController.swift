//
//  TimerListController.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import UIKit

class TimerListController: UIViewController {

    @IBOutlet weak var timerList: UITableView!
    
    var model: TimerListModel? = nil {
        didSet {
            self.timerList.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(self.addNewTimer)
        )
        
        self.model = UserDefaultManager.getValue(with: .timerInfo)

        self.timerList.setCell(cellName: TimerCell.self)
        self.timerList.delegate = self
        self.timerList.dataSource = self

    }
    
    @objc
    func addNewTimer() {
        let vc = AddTimerViewController(nibName: "AddTimerViewController", bundle: nil)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
}

extension TimerListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.records.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.loadCell(identifier: TimerCell.self, indexPath: indexPath)
        if let record = self.model?.records[indexPath.item] {
            cell.setUI(with: record)
        }
        
        return cell
    }

    
}


extension TimerListController: AddTimerProtocol {
    func addTimer(didFinishWith data: TimerListModel) {
        self.model = data
    }
}
