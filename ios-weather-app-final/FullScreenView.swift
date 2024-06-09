import SwiftUI

struct FullScreenView: View {
  let locations: [(String, Double, String)]
  @Binding var selectedIndex: Int
  @Binding var isFullScreen: Bool
  @Binding var isCelsius: Bool

  var body: some View {
    VStack {
      Spacer()

      if selectedIndex >= 0 && selectedIndex < locations.count {
        VStack {
          Text(locations[selectedIndex].0)
            .font(.title)

          Text(formattedTemperature(locations[selectedIndex].1))
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

struct BottomBar: View {
  @Binding var selectedIndex: Int
  let locations: [(String, Double, String)]
  @Binding var isFullScreen: Bool

  private let activeColor: Color = .blue
  private let inactiveColor: Color = .gray

  var body: some View {
    HStack {
      Image(systemName: "map")
        .font(.title)
        .foregroundColor(.blue)

      Spacer()

      HStack(spacing: 8) {
        ForEach(0..<locations.count) { index in
          if index == 0 {
            Image(systemName: "location.fill")
              .foregroundColor(index == selectedIndex ? activeColor : inactiveColor)
          } else {
            Circle()
              .fill(index == selectedIndex ? activeColor : inactiveColor)
              .frame(width: 8, height: 8)
          }
        }
      }
      .padding(.horizontal)

      Spacer()
      Button(action: {
        isFullScreen = false  // Exit full-screen view
      }) {
        Image(systemName: "list.bullet")
          .font(.title)
          .foregroundColor(.blue)
      }

    }
    .padding(.vertical, 8)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .shadow(radius: 4)
  }
}
