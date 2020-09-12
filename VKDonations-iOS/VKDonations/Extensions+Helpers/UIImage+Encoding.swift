//
//  UIImage+Encoding.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
