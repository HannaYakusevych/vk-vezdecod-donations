//
//  DonateTypeViewController.swift
//  VKDonations
//
//  Created by Анна Якусевич on 11.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit
import SnapKit

class DonateTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        addMainView()
        
//        let url = URL(string: "https://vkhackstub.herokuapp.com/donate/list")!
//
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
//        }
//
//        task.resume()
    }


}

private extension DonateTypeViewController {
    func setupUI() {
        view.backgroundColor = .backgroundContent
        title = .donationType
        
        navigationController?.navigationBar.tintColor = .headerText
    }
    
    func addMainView() {
        let contentView = UIView()
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { maker in
            maker.height.equalTo(148)
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        
        let oneTimeView = addDonationTypeView(imageName: "target_icon", title: .oneTimeDonationTitle, subtitle: .oneTimeDonationDescription) { [weak self] in
            let viewController = Assembly().donateCreationViewController(.oneTime)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        contentView.addSubview(oneTimeView)
        oneTimeView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(8)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.height.equalTo(62)
        }
        
        let repeatingView = addDonationTypeView(imageName: "calendar_icon", title: .repeatableDonationTitle, subtitle: .repeatableDonationDescription) { [weak self] in
            let viewController = Assembly().donateCreationViewController(.oneTime)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        contentView.addSubview(repeatingView)
        repeatingView.snp.makeConstraints { maker in
            maker.top.equalTo(oneTimeView.snp.bottom).offset(12)
            maker.leading.equalToSuperview().offset(12)
            maker.trailing.equalToSuperview().offset(-12)
            maker.bottom.equalToSuperview().offset(-4)
        }
    }
    
    func addDonationTypeView(imageName: String, title: String, subtitle: String, action: (() -> Void)?) -> UIView {
        let view = UIView()
        view.backgroundColor = .backgroundContentTint
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.33
        view.layer.borderColor = UIColor.imageBorder?.cgColor
        
        // Right image
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right_arrow")
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.width.equalTo(48)
        }
        
        // Left image
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: imageName)
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { maker in
            maker.width.height.equalTo(28)
            maker.leading.top.equalToSuperview().offset(12)
        }
        
        // Texts
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        view.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(12)
            maker.bottom.equalToSuperview().offset(-12)
            maker.leading.equalTo(iconImageView.snp.trailing).offset(12)
            maker.trailing.equalTo(imageView.snp.leading).offset(12)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .textPrimary
        titleLabel.text = title
        stackView.addArrangedSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .textSubhead
        subtitleLabel.text = subtitle
        stackView.addArrangedSubview(subtitleLabel)
        
        view.enableTapping { [weak view] in
            view?.showAnimation {
              action?()
            }
        }
        
        return view
    }
}
