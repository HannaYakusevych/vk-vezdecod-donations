//
//  CustomDashedView.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

class CustomDashedView: UIView {

    private let borderLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        borderLayer.strokeColor = UIColor.accentsAccent?.cgColor
        borderLayer.lineDashPattern = [3,3]
        borderLayer.backgroundColor = UIColor.backgroundContent?.cgColor
        borderLayer.fillColor = UIColor.backgroundContent?.cgColor
        
        layer.cornerRadius = 10
        layer.addSublayer(borderLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

        borderLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: 10).cgPath
    }
}
