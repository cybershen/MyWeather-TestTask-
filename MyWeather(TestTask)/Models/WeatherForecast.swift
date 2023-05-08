//
//  WeatherForecast.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 06.05.2023.
//

import Foundation

struct WeatherForecast: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}
