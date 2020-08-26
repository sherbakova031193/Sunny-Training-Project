//
//  CurrentWeather.swift
//  Sunny
//
//  Created by Елизавета Щербакова on 21.03.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature)
    }
    let conditionCode: Int
    var systemIconNameString: String {
        
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "cloud.fog.fill"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign" 
        }
        
    }
    
    init? (currentWeatheerData: CurrentWeatherData) {
        cityName = currentWeatheerData.name
        temperature = currentWeatheerData.main.temp
        feelsLikeTemperature = currentWeatheerData.main.feelsLike
        conditionCode = currentWeatheerData.weather.first!.id
        
    }
}
