//
//  Donate.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import Foundation

struct Donate: Codable {
    let title: String
    let price: Int
    let purpose: String
    let donateType: DonateType
    let description: String
    let startDate: Date
    var endDate: Date?
    let bankCard: String
    let author: String
}

enum DonateType: String, Codable {
    case onetime = "ONETIME"
    case repeatable = "REPEATABLE"
}
