//
//  Weather.swift
//  weather-app
//
//  Created by Soultan Muhammad Albar on 12/06/22.
//

import Foundation


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}
