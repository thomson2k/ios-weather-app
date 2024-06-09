//
//  WeatherAPIManager.swift
//  weather-app2
//
//  Created by Tomasz Watroba on 08/06/2024.
//

import Foundation
//
//struct WeatherData: Codable {
//    let location: LocationData
//    let current: CurrentWeatherData
//
//    struct LocationData: Codable {
//        let name: String
//        let lat: Double
//        let lon: Double
//    }
//
//    struct CurrentWeatherData: Codable {
//        let temp_c: Double
//        let temp_f: Double
//        let condition: WeatherConditionData
//    }
//
//    struct WeatherConditionData: Codable {
//        let text: String
//        let icon: String
//    }
//}
//
//class WeatherAPIManager {
//    private let apiKey = "3a71f1ea6bd14697adc185822240806"
//
//    func fetchWeather(for location: String, completion: @escaping (WeatherData?) -> Void) {
//        let urlString = "http://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(location)"
//
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//
//            let decoder = JSONDecoder()
//            let weatherData = try? decoder.decode(WeatherData.self, from: data)
//            completion(weatherData)
//        }.resume()
//    }
//}
