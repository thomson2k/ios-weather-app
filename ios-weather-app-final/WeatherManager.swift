
    import Foundation
    import CoreLocation

    class WeatherManager {
        private let apiKey = ""

        func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                    return
                }

                do {
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completion(.success(weatherResponse))
                } catch {
                    print("Decoding error: \(error)")
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                    completion(.failure(error))
                }
            }.resume()
        }
    }

    struct WeatherResponse: Decodable {
        let main: WeatherData
        let weather: [WeatherCondition]
    }

    struct WeatherData: Decodable {
        let temp: Double
    }

    struct WeatherCondition: Decodable {
        let description: String
    }
