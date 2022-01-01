//
//  TimerListController.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import UIKit

class TimerListController: UIViewController {

    @IBOutlet weak var timerList: UICollectionView!
    
    var model: TimerListModel? = nil {
        didSet {
            self.timerList.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(self.addNewTimer)
        )
        
        self.model = UserDefaultManager.getValue(with: .timerInfo)

        self.timerList.setCell(cellName: TimerPlayerCell.self)
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

extension TimerListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.records.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.loadCell(identifier: TimerPlayerCell.self, indexPath: indexPath)
        cell.addShadowWithRoundedCorners()
        if let record = self.model?.records[indexPath.item] {
            cell.setUI(with: record)
        }

        return cell
    }
    
    
}

extension TimerListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 123)
    }
}


extension TimerListController: AddTimerProtocol {
    func addTimer(didFinishWith data: TimerListModel) {
        self.model = data
    }
}
