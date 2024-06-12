import SwiftUI

struct WeatherCard: View {
    var city: String
    var country: String
    var latitude: Double
    var longitude: Double
    @Binding var isCelsius: Bool
    var onDelete: () -> Void

    @State private var temperature: Double?
    @State private var weatherCondition: String?
    @State private var isLoading = true
    @Binding var isFullScreen: Bool
    @Binding var selectedIndex: Int

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if let temperature = temperature, let weatherCondition = weatherCondition {
                Text("\(city), \(country)")
                    .font(.headline)
                Text("\(convertTemperature(temperature)) \(isCelsius ? "°C" : "°F")")
                    .font(.largeTitle)
                Text(weatherCondition)
                    .font(.subheadline)
            } else {
                Text("Error loading weather data")
            }

            Button(action: onDelete) {
                Text("Delete")
                    .foregroundColor(.red)
            }
        }
        .onTapGesture {
            isFullScreen = true
            // Set selectedIndex to the index of this weather card
            // You may need to find the index of this card in the locations array and assign it to selectedIndex
            // For simplicity, I'm assuming you have a way to get the index directly
            selectedIndex = 0 // You need to set the correct index here
        }
        .onAppear {
            fetchWeather()
        }
    }

    private func convertTemperature(_ temperature: Double) -> Double {
        if isCelsius {
            return temperature
        } else {
            return temperature * 9 / 5 + 32
        }
    }

    private func fetchWeather() {
        // Your weather fetching logic here
        // This is just a placeholder
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.temperature = 20
            self.weatherCondition = "Sunny"
        }
    }
}
