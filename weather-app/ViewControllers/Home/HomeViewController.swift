//
//  ViewController.swift
//  weather-app
//
//  Created by Soultan Muhammad Albar on 12/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let weatherViewModel = WeatherViewModel()
    let homeView = HomeView()
    var weatherItems:[WeatherEntities] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func setupView() {
        view.addSubview(homeView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            homeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            homeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    fileprivate func setupConfiguration() {
        homeView.searchTextField.delegate = self
        
        weatherViewModel.delegate = self
        
    }
    
    private func fetchWeather() {
        do {
            let result = try context.fetch(WeatherEntities.fetchRequest())
            weatherItems = result
            weatherViewModel.fetchWeather(cityName: result.count > 0 ? result[0].cityName! : "Yogyakarta")
            print("awoekaowe \(result)")
        } catch {
            print(error)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupConfiguration()
        fetchWeather()
    }
}

extension HomeViewController: WeatherDelegate {
    func didUpdate(modelData: Decodable) {
        let weatherData = modelData as? WeatherData
        if let weatherResult = weatherData {
            DispatchQueue.main.async {
                self.homeView.cityLabel.text = "\(weatherResult.name)\n\(weatherResult.main.temp) \(weatherResult.weather[0].description)"
            }
        }
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
}


extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        homeView.searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if homeView.searchTextField.text != "" {
            return true
        } else {
            homeView.searchTextField.placeholder = "Type the city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = homeView.searchTextField.text {
            let newWeather = weatherItems.count > 0 ? weatherItems[0] : WeatherEntities(context: context)
            newWeather.cityName = city
            
            do {
                try context.save()
            } catch {
                print("Error save core data \(error)")
            }
            
            fetchWeather()
            
        }
        homeView.searchTextField.clear()
    }
    
}
