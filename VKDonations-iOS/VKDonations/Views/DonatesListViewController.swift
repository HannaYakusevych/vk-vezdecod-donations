//
//  DonatesListViewController.swift
//  VKDonations
//
//  Created by Анна Якусевич on 11.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit
import SnapKit

class DonatesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        // TODO: Add network request
        addEmptyView()
    }


}

private extension DonatesListViewController {
    func setupUI() {
        view.backgroundColor = .backgroundContent
        title = .donates
        
        navigationController?.navigationBar.tintColor = .headerTint
        
        // For the next screen
        let item = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        item.tintColor = .headerTint
        navigationItem.backBarButtonItem = item
        
        // TODO: Add different separator (with insets)
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.shadowColor = .separatorCommon
            navBarAppearance.backgroundColor = .headerBackground

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            navigationController?.navigationBar.shadowImage = UIImage(color: UIColor.separatorCommon!)
            navigationController?.navigationBar.backgroundColor = .headerBackground
        }
    }
    
    func addEmptyView() {
        let contentView = UIView()
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { maker in
            maker.height.equalTo(196)
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        
        let label = UILabel()
        label.text = .emptyDonationsList
        label.textColor = .textSecondary
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2
        contentView.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(48)
            maker.leading.equalToSuperview().offset(32)
            maker.trailing.equalToSuperview().offset(-32)
        }
        
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonPrimaryBackground
        button.layer.cornerRadius = 10
        button.setTitle(.createDonation, for: .normal)
        button.tintColor = .buttonPrimaryForeground
        button.setTitleColor(.buttonPrimaryForeground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        contentView.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-48)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(36)
            maker.width.equalTo(133)
        }
        
        button.enableTapping { [weak self] in
            let vc = DonateTypeViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContext(size)
        
        color.setFill()
        
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        
        self.init(cgImage: cgImage)
    }
}
