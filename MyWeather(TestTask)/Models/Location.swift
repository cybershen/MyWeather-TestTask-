//
//  Location.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 06.05.2023.
//

import Foundation

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String
}
