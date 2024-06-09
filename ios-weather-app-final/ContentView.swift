import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

     @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State private var selectedSetting: String? // State variable to track the selected settings option
    @State private var selectedTemperatureUnit = "Celsius" // State variable to track the selected temperature unit
    @State private var searchText = "" // State variable to store the search text
    @State private var weatherData = [("New York", 25.0, "Clear"), ("London", -1.0, "Cloudy"), ("Tokyo", 29.0, "Rainy")]
    @State private var isFullScreen = false
    @State private var selectedIndex = 0
    @State private var isCelsius = true

    @State private var showSettings = false

    var body: some View {
        NavigationView {
            
            VStack {
                SearchBar(searchText: $searchText)
                    .padding()
                
                Spacer()
                
                if let selectedSetting = selectedSetting {
                    Text("Selected Setting: \(selectedSetting)")
                        .padding()
                }
                
                Text("Temperature Unit: \(isCelsius ? "Celsius" : "Fahrenheit")")
                    .padding()
                
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                                            ForEach(weatherData.indices, id: \.self) { index in
                                                WeatherCard(location: weatherData[index].0,
                                                            temperature: convertTemperature(weatherData[index].1),
                                                            weatherCondition: weatherData[index].2,
                                                            onDelete: {
                                                                weatherData.remove(at: index)
                                                            },
                                                            onFullScreen: {
                                                                self.selectedIndex = index
                                                                self.isFullScreen.toggle()
                                                            })
                                            }
                                        }
                                    .padding()
                                }
            }
            .navigationBarTitle("Weather")
            .navigationBarItems(trailing:
                Menu {
                    Button("Option 1") {
                        selectedSetting = "Edit List"
                    }
                    Divider()
                    Picker("Temperature Unit", selection: $isCelsius) {
                        Text("°C").tag(true)
                        Text("°F").tag(false)
                    }
                    Divider()
                    Button("Cancel") {}
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title)
                        .padding()
                }
            )
            .fullScreenCover(isPresented: $isFullScreen) {
                            FullScreenView(locations: weatherData, selectedIndex: $selectedIndex, isFullScreen: $isFullScreen, isCelsius: $isCelsius)
                        }
        }
    }
    
    private func convertTemperature(_ temperature: Double) -> Double {
            if isCelsius {
                return temperature
            } else {
                return temperature * 9 / 5 + 32
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
