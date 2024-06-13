import SwiftUI

struct FullScreenView: View {
    let locations: [Location]
    @Binding var selectedIndex: Int
    @Binding var isFullScreen: Bool
    @Binding var isCelsius: Bool

    // Additional properties for extended weather data
    @State private var hourlyTemperatures: [HourlyTemperature] = []
    @State private var dailyForecasts: [DailyForecast] = []
    @State private var minTemperature: Double?
    @State private var maxTemperature: Double?

    var body: some View {
        VStack {
            Spacer()

            if selectedIndex >= 0 && selectedIndex < locations.count {
                VStack {
                    Text(locations[selectedIndex].city ?? "Unknown")
                        .font(.title)
                    
                    Text(formattedTemperature(locations[selectedIndex].lat))
                        .font(.headline)
                    
                    if let minTemperature = minTemperature, let maxTemperature = maxTemperature {
                        Text("Min: \(convertTemperature(minTemperature)) \(isCelsius ? "°C" : "°F")")
                            .font(.subheadline)
                        Text("Max: \(convertTemperature(maxTemperature)) \(isCelsius ? "°C" : "°F")")
                            .font(.subheadline)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hourly Forecast")
                            .font(.headline)
                        ForEach(hourlyTemperatures, id: \.time) { hourlyTemp in
                            Text("\(hourlyTemp.time): \(convertTemperature(hourlyTemp.temperature)) \(isCelsius ? "°C" : "°F")")
                                .font(.subheadline)
                        }
                    }
                    .padding(.top)

                    Divider()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("7-Day Forecast")
                            .font(.headline)
                        ForEach(dailyForecasts, id: \.date) { dailyForecast in
                            Text("\(dailyForecast.date): \(convertTemperature(dailyForecast.temperature)) \(isCelsius ? "°C" : "°F")")
                                .font(.subheadline)
                        }
                    }
                    .padding(.top)
                }
                .transition(.slide)
            }

            Button(action: {
                // Action to go back to home screen
                isFullScreen = false
            }) {
                Image(systemName: "house.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 24))
                    .padding()
            }

            Spacer()

            TabView(selection: $selectedIndex) {
                Text("")
                    .tabItem {
                        Indicators(selectedIndex: $selectedIndex, locations: locations)
                    }
                    .tag(1)

                Text("Home")
                    .tabItem {
                        Label("Home", systemImage: "list.bullet")
                    }
                    .tag(2)
            }
            
            IndicatorDots(selectedIndex: $selectedIndex, count: locations.count)
                .padding(.bottom)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -100 {
                        if selectedIndex < locations.count - 1 {
                            selectedIndex += 1
                        }
                    } else if value.translation.width > 100 {
                        if selectedIndex > 0 {
                            selectedIndex -= 1
                        }
                    }
                }
        )
        .onAppear {
            fetchWeatherDetails()
        }
    }

    private func formattedTemperature(_ temperature: Double) -> String {
        if isCelsius {
            return "\(Int(temperature))°C"
        } else {
            let fahrenheit = temperature * 9 / 5 + 32
            return "\(Int(fahrenheit))°F"
        }
    }

    private func convertTemperature(_ temperature: Double) -> Double {
        if isCelsius {
            return temperature
        } else {
            return temperature * 9 / 5 + 32
        }
    }

    private func fetchWeatherDetails() {
        // Simulated data fetching process, replace with actual weather API integration
        // This is just a placeholder
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.minTemperature = 15
            self.maxTemperature = 25
            self.hourlyTemperatures = [
                HourlyTemperature(time: "12:00 PM", temperature: 22),
                HourlyTemperature(time: "1:00 PM", temperature: 23),
                HourlyTemperature(time: "2:00 PM", temperature: 24),
                HourlyTemperature(time: "3:00 PM", temperature: 25),
                HourlyTemperature(time: "4:00 PM", temperature: 24),
                HourlyTemperature(time: "5:00 PM", temperature: 23),
                HourlyTemperature(time: "6:00 PM", temperature: 22)
            ]
            self.dailyForecasts = [
                DailyForecast(date: "Monday", temperature: 21),
                DailyForecast(date: "Tuesday", temperature: 23),
                DailyForecast(date: "Wednesday", temperature: 24),
                DailyForecast(date: "Thursday", temperature: 25),
                DailyForecast(date: "Friday", temperature: 26),
                DailyForecast(date: "Saturday", temperature: 25),
                DailyForecast(date: "Sunday", temperature: 24)
            ]
        }
    }
}

struct Indicators: View {
    @Binding var selectedIndex: Int
    let locations: [Location]

    var body: some View {
        VStack {
            ForEach(locations.indices, id: \.self) { index in
                Text(locations[index].city ?? "Unknown")
                    .onTapGesture {
                        selectedIndex = index
                    }
                    .padding()
                    .background(selectedIndex == index ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

struct IndicatorDots: View {
    @Binding var selectedIndex: Int
    let count: Int

    var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { index in
                if index == 0 {
                    Image(systemName: "location.fill")
                        .foregroundColor(index == selectedIndex ? Color.blue : Color.gray)
                } else {
                    Circle()
                        .fill(index == selectedIndex ? Color.blue : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding()
    }
}

struct HourlyTemperature: Identifiable {
    var id = UUID()
    var time: String
    var temperature: Double
}

struct DailyForecast: Identifiable {
    var id = UUID()
    var date: String
    var temperature: Double
}
