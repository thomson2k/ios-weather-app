import SwiftUI
import CoreData
import UIKit
import MapKit

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Location.entity(),
        sortDescriptors: []
    ) private var locations: FetchedResults<Location>

    @State private var selectedSetting: String?
    @State private var searchText = ""
    @State private var searchResults: [MKLocalSearchCompletion] = []
    @State private var isFullScreen = false
    @State private var selectedIndex = 0
    @State private var isCelsius = true
    @State private var showSearchResults = true

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    SearchBar(searchText: $searchText, searchResults: $searchResults, showSearchResults: $showSearchResults, onCitySelected: { city in
                        fetchCoordinates(for: city)
                    })
                    .padding()

                    if showSearchResults && !searchResults.isEmpty {
                        SearchResultListView(searchResults: $searchResults) { result in
                            fetchCoordinates(for: result.title)
                            showSearchResults = false
                        }
                        .frame(height: 200) // Adjust height as needed
                    }
                }

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
                        ForEach(locations) { location in
                            WeatherCard(city: location.city ?? "Unknown",
                                                                   country: location.country ?? "Unknown",
                                                                   latitude: location.lat,
                                                                   longitude: location.lng,
                                                                   isCelsius: $isCelsius,
                                                                   onDelete: {
                                                                       deleteLocation(location)
                                                                   },
                                                                   isFullScreen: $isFullScreen,
                                                                   selectedIndex: $selectedIndex)
                                        
                            
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
                            FullScreenView(locations: Array(locations), selectedIndex: $selectedIndex, isFullScreen: $isFullScreen, isCelsius: $isCelsius)
                        }

        }
    }

    private func fetchCoordinates(for city: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = city

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response, let item = response.mapItems.first else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let cityName = item.placemark.locality ?? "Unknown"
            let countryName = item.placemark.country ?? "Unknown"
            let lat = item.placemark.coordinate.latitude
            let lng = item.placemark.coordinate.longitude

            saveLocation(city: cityName, country: countryName, lat: lat, lng: lng)
        }
    }

    private func saveLocation(city: String, country: String, lat: Double, lng: Double) {
        let newLocation = Location(context: viewContext)
        newLocation.city = city
        newLocation.country = country
        newLocation.lat = lat
        newLocation.lng = lng

        do {
            try viewContext.save()
        } catch {
            print("Error saving location: \(error.localizedDescription)")
        }
    }

    private func deleteLocation(_ location: Location) {
        viewContext.delete(location)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting location: \(error.localizedDescription)")
        }
    }
}
