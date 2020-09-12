//
//  Strings.swift
//  VKDonations
//
//  Created by Анна Якусевич on 11.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import Foundation

extension String {
    static let donates = "Пожертвования"
    static let emptyDonationsList = """
У Вас пока нет сборов.
Начните доброе дело.
"""
    static let createDonation = "Создать сбор"
    
    static let donationType = "Тип сбора"
    static let oneTimeDonationTitle = "Целевой сбор"
    static let oneTimeDonationDescription = "Когда есть определенная цель"
    static let repeatableDonationTitle = "Регулярный сбор"
    static let repeatableDonationDescription = "Если помощь нужна ежемесячно"
    
    static let addImage = "Загрузить обложку"
    static let donateName = "Название сбора"
    static let sumTitle = "Сумма, ₽"
    static let sumPlaceholder = "Сколько нужно собрать?"
    static let purpose = "Цель"
    static let purposePlaceholder = "Например, лечение человека"
    static let donationDescription = "Описание"
    static let donationDescriptionPlaceholder = "На что пойдут деньги и как они кому-то помогут?"
    static let bankCard = "Счет VK Pay 1234" // Заглушка для параметра
    static let bankCardTitle = "Куда получать деньги"
    static let name = "Матвей Правосудов" // Заглушка для автора
    static let nameTitle = "Автор"
    static let continueButton = "Далее"
}
