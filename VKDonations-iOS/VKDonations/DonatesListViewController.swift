//
//  DonatesListViewController.swift
//  VKDonations
//
//  Created by Анна Якусевич on 11.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

class DonatesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigation()
        view.backgroundColor = .white
    }


}

private extension DonatesListViewController {
    func setupNavigation() {
        title = "Пожертвование"
    }
}

