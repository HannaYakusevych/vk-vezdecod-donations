//
//  SingleChoiceView.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

protocol SingleChoiceViewDelegate: class {
    func userDidChoose(_ option: Int)
}

final class SingleChoiceView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .textSubhead
        return titleLabel
    }()
    
    private lazy var cells = [SingleChoiceViewCell]()
    
    private weak var delegate: SingleChoiceViewDelegate?
    
    private var selectedOption = 0 {
        didSet {
            cells[selectedOption].select()
            cells[oldValue].deselect()
        }
    }
    
    func setup(title: String, delegate: SingleChoiceViewDelegate) {
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(14)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
        }
        
        let firstCell = SingleChoiceViewCell()
        firstCell.setup(title: .endAfterSum, isSelected: true) { [weak self] in
            self?.selectedOption = 0
            self?.delegate?.userDidChoose(0)
        }
        cells.append(firstCell)
        addSubview(firstCell)
        firstCell.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.leading.trailing.equalToSuperview()
        }
        
        let secondCell = SingleChoiceViewCell()
        secondCell.setup(title: .endOnDate, isSelected: false) { [weak self] in
            self?.selectedOption = 1
            self?.delegate?.userDidChoose(1)
        }
        cells.append(secondCell)
        addSubview(secondCell)
        secondCell.snp.makeConstraints { maker in
            maker.top.equalTo(firstCell.snp.bottom)
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-12)
        }
        
        snp.makeConstraints { $0.height.equalTo(140) }
        
        self.delegate = delegate
    }
}

final class SingleChoiceViewCell: UIView {
    
    private lazy var iconView = UIImageView()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.textColor = .textPrimary
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    func setup(title: String, isSelected: Bool, tapHandler: (() -> Void)?) {
        snp.makeConstraints { $0.height.equalTo(44) }
        addSubview(iconView)
        iconView.snp.makeConstraints { maker in
            maker.centerY.leading.height.equalToSuperview()
            maker.width.equalTo(48)
        }
        iconView.image = isSelected ? UIImage(named: "state_on") : UIImage(named: "state_off")
        
        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.equalTo(iconView.snp.trailing)
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().offset(-12)
        }
        label.text = title
        
        if let tapHandler = tapHandler {
            enableTapping(tapHandler)
        }
    }
    
    func select() {
        iconView.image = UIImage(named: "state_on")
    }
    
    func deselect() {
        iconView.image = UIImage(named: "state_off")
    }
}
