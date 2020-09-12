//
//  DonateCreationViewBuilder.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

final class DonateCreationViewBuilder {
    func imagePlaceholderView() -> UIView {
        // TODO: Add delete button
        let view = CustomDashedView()
        view.snp.makeConstraints { $0.height.equalTo(140) }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.contentMode = .scaleAspectFit
        view.addSubview(stackView)
        stackView.snp.makeConstraints { $0.center.equalToSuperview() }
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        stackView.addArrangedSubview(imageView)
        
        let label = UILabel()
        label.textColor = .accentsAccent
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = .addImage
        stackView.addArrangedSubview(label)
        
        return view
    }
    
    func continueButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonPrimaryBackground
        button.layer.cornerRadius = 10
        button.setTitle(title, for: .normal)
        button.tintColor = .buttonPrimaryForeground
        button.setTitleColor(.buttonPrimaryForeground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.snp.makeConstraints { maker in
            maker.height.equalTo(44)
        }
        return button
    }
}
