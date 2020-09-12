//
//  ChoiceView.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

final class ChoiceView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .textSubhead
        return titleLabel
    }()
    
    private lazy var textLabel: UILabel = {
        let view = UILabel()
        view.textColor = .textPrimary
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    func setup(title: String, default: String? = nil, tapHandler: (() -> Void)? = nil) {
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.top.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
        }
        
        let textView = UIView()
        textView.backgroundColor = .fieldBackground
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 0.33
        textView.layer.borderColor = UIColor.fieldBorder?.cgColor
        
        addSubview(textView)
        textView.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.bottom.equalToSuperview().offset(-12)
        }
        
        // Right image
        let imageView = UIImageView()
        imageView.image = UIImage(named: "down_arrow")
        textView.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.width.equalTo(44)
        }
        
        textLabel.text = `default`
        textView.addSubview(textLabel)
        textLabel.snp.makeConstraints { maker in
            maker.top.leading.equalToSuperview().offset(12)
            maker.bottom.equalToSuperview().offset(-12)
            maker.trailing.equalTo(imageView.snp.leading).offset(-12)
        }
        
        snp.makeConstraints { $0.height.equalTo(96) }
        
        if let tapHandler = tapHandler {
            enableTapping(tapHandler)
        }
    }
    
    func setText(_ text: String) {
        textLabel.text = text
    }
    
    func getText() -> String {
        return textLabel.text ?? ""
    }
}
