import SwiftUI
import MapKit
import CoreLocation

struct FullScreenView: View {
    let locations: [Location]
    @Binding var selectedIndex: Int
    @Binding var isFullScreen: Bool
    @Binding var isCelsius: Bool

    var body: some View {
        VStack {
            Spacer()

            if selectedIndex >= 0 && selectedIndex < locations.count {
                VStack {
                    Text(locations[selectedIndex].city ?? "Unknown")
                        .font(.title)
                    
                    Text(formattedTemperature(locations[selectedIndex].lat))
                        .font(.headline)
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
//                Map(coordinateRegion: $region, showsUserLocation: true)
//                    .tabItem {
//                        Label("Maps", systemImage: "map")
//                    }
//                    .tag(0)

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
    }

    private func formattedTemperature(_ temperature: Double) -> String {
        if isCelsius {
            return "\(Int(temperature))°C"
        } else {
            let fahrenheit = temperature * 9 / 5 + 32
            return "\(Int(fahrenheit))°F"
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
