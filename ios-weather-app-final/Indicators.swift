////
////  Indicators.swift
////  ios-weather-app-final
////
////  Created by Tomasz Watroba on 09/06/2024.
////
//
//import SwiftUI
//
//
//struct Indicators: View {
//    @Binding var selectedIndex: Int
//    let locations: [(String, Double, String)]
//
//    private let activeColor: Color = .blue
//    private let inactiveColor: Color = .gray
//
//    var body: some View {
//        HStack {
//            Image(systemName: "map")
//                .font(.title)
//                .foregroundColor(.blue)
//            
//            Spacer()
//
//            HStack(spacing: 8) {
//                ForEach(0..<locations.count) { index in
//                    if index == 0 {
//                        Image(systemName: "location.fill")
//                            .foregroundColor(index == selectedIndex ? activeColor : inactiveColor)
//                    } else {
//                        Circle()
//                            .fill(index == selectedIndex ? activeColor : inactiveColor)
//                            .frame(width: 8, height: 8)
//                    }
//                }
//            }
//            .padding(.horizontal)
//            
//            Spacer()
//        }
//        .padding(.vertical, 8)
//        .background(Color.white)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .shadow(radius: 4)
//    }
//}
