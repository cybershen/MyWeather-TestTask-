//
//  Condition.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 06.05.2023.
//

import Foundation

struct Current: Codable {
    let temp_c: Double
    let condition: Condition
}
