//
//  Assembly.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import Foundation

final class Assembly {
    func donateCreationViewController(_ flowType: DonateCreationViewController.FlowType) -> DonateCreationViewController {
        return DonateCreationViewController(flowType: flowType)
    }
}
