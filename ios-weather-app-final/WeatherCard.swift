import SwiftUI

struct WeatherCard: View {
    let location: String
    let temperature: Double
    let weatherCondition: String
    var onDelete: (() -> Void)?
    var onFullScreen: (() -> Void)?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(gradient: backgroundGradient(), startPoint: .top, endPoint: .bottom))
                .shadow(radius: 4)
            
            VStack {
                Text(location)
                    .font(.title)
                    .padding()
                
                Text(formattedTemperature(temperature))
                    .font(.headline)
                    .padding()
            }
        }
        .frame(height: 200)
        .onTapGesture {
            self.onFullScreen?()
        }
        .swipeActions(edge: .trailing) {
            Button {
                self.onDelete?()
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
        }
    }
    
    private func backgroundGradient() -> Gradient {
        let hour = Calendar.current.component(.hour, from: Date())
        let timeOfDay: TimeOfDay = {
            switch hour {
            case 6..<12: return .morning
            case 12..<18: return .afternoon
            case 18..<21: return .evening
            default: return .night
            }
        }()
        
        let temperatureCategory: TemperatureCategory = {
            switch temperature {
            case ..<10: return .cold
            case 10..<25: return .warm
            default: return .hot
            }
        }()
        
        return gradient(for: timeOfDay, temperatureCategory: temperatureCategory, weatherCondition: weatherCondition)
    }
    
    private func gradient(for timeOfDay: TimeOfDay, temperatureCategory: TemperatureCategory, weatherCondition: String) -> Gradient {
        // Define your gradients here based on the conditions
        switch (timeOfDay, temperatureCategory, weatherCondition.lowercased()) {
        case (.morning, .cold, _): return Gradient(colors: [Color.blue, Color.white])
        case (.afternoon, .warm, "clear"): return Gradient(colors: [Color.orange, Color.yellow])
        case (.evening, .hot, _): return Gradient(colors: [Color.purple, Color.blue])
        case (.night, _, "rainy"): return Gradient(colors: [Color.black, Color.gray])
        // Add more conditions as needed
        default: return Gradient(colors: [Color.gray, Color.white])
        }
    }
    
    private func formattedTemperature(_ temperature: Double) -> String {
        return "\(Int(temperature))°C"
    }
    
    enum TimeOfDay {
        case morning, afternoon, evening, night
    }
    
    enum TemperatureCategory {
        case cold, warm, hot
    }
}

struct WeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCard(location: "San Francisco", temperature: 18.0, weatherCondition: "Clear", onDelete: {}, onFullScreen: {})
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
