//
//  TitleButton.swift
//  MultiTimer
//
//  Created by Dayeon Jung on 2022/01/01.
//

import UIKit

struct TitleButtonModel {
    let title: String
    let titleColor: UIColor?
    let bgColor: UIColor?
}

@IBDesignable
class TitleButton: UIButton {
    
    private var viewModel: TitleButtonModel? {
        didSet {
            self.setUI()
        }
    }
    
    public var onClick = { () }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        self.tintColor = .black
        
        self.addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
    }
    
    public func setModel(with viewModel: TitleButtonModel) {
        self.viewModel = viewModel
    }
    
    private func setUI() {
        
        if let title = self.viewModel?.title {
            self.setTitle(title, for: .normal)
        }
        
        if let bg = self.viewModel?.bgColor {
            self.backgroundColor = bg
        }
        
        if let titleColor = self.viewModel?.titleColor {
            self.setTitleColor(titleColor, for: .normal)
        }
        
    }
    
    @objc private func clickAction(button: UIButton) {
        self.onClick()
    }
    
}
