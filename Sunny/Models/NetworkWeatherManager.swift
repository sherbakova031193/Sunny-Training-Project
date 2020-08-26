//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by Елизавета Щербакова on 21.03.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation
import CoreLocation



class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, logitude: CLLocationDegrees)
    }
    
    var onCopletion: ((CurrentWeather) -> Void)?
    
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        
        var urlString = ""
        
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric" //https:
        case .coordinate(let latitude, let logitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(logitude)&appid=\(apiKey)&units=metric"//https:
        }
        performRequest(withUrlString: urlString)
    }
    
    fileprivate func performRequest(withUrlString urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default) // в 99% используется
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCopletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatheerData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

