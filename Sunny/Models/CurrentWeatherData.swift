//
//  CurrentWeatherData.swift
//  Sunny
//
//  Created by Елизавета Щербакова on 21.03.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like" // смена имени
        
    }
}

struct Weather: Codable {
    let id: Int
}
