//
//  UIImage + Extentions.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 02.05.2023.
//

import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case house = "house"
        case magnifyingGlass = "magnifyingglass"
    }
    
    convenience init(assetIdentifier: AssetIdentifier) {
        self.init(systemName: assetIdentifier.rawValue)!
    }
}
