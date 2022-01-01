//
//  TimerListController.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import UIKit

class TimerListController: UIViewController {

    @IBOutlet weak var timerList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.timerList.setCell(cellName: TimerPlayerCell.self)
        self.timerList.delegate = self
        self.timerList.dataSource = self
        
    }


}

extension TimerListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.loadCell(identifier: TimerPlayerCell.self, indexPath: indexPath)
        return cell
    }
    
    
}

extension TimerListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}
