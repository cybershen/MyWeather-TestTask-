//
//  Day.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 06.05.2023.
//

import Foundation

struct Day: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: Condition
}
