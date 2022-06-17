//
//  WeatherViewModel.swift
//  weather-app
//
//  Created by Soultan Muhammad Albar on 12/06/22.
//

import Foundation

protocol WeatherDelegate {
    func didUpdate(modelData: Decodable)
    func didFailWithError(error: String)
}

class WeatherViewModel {
    
    let networkService = NetworkService()
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?APPID=11d31a5df29c57437aefbe8e00d48b2b&units=metric"
    
    var weather: ObservableObject<WeatherData?> = ObservableObject(nil)
    var delegate: WeatherDelegate?
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        networkService.performRequest(WeatherData.self, with: urlString) { [weak self] result in
            if let finalResult = try? result.get() as? WeatherData {
                self?.weather.value = finalResult
                self?.delegate?.didUpdate(modelData: finalResult)
                print(finalResult)
            } else {
                print("errorr")
                self?.delegate?.didFailWithError(error: "Some error happened")
            }
            
        }
    }
}
