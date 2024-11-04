//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mathieu Cardaropoli on 28/10/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        NavigationView {
            ZStack {

                Color(hue: 0.564, saturation: 0.408, brightness: 0.858).edgesIgnoringSafeArea(.all)
                
                VStack {
                    if let location = locationManager.location {
                        // Affichage des coordonnées et du nom de la ville 
                        if let weather = weather {
                            Text("Current location: \(weather.name) (\(location.longitude), \(location.latitude))")
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        } else {
                            Text("Your coordinates are: \(location.longitude), \(location.latitude)")
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        }
                        
                        if let weather = weather {
                            NavigationLink(destination: WeatherView(weather: weather)
                                            .background(Color(hue: 0.564, saturation: 0.408, brightness: 0.858))) {
                                Text("View Weather")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        } else {
                            LoadingView()
                                .task {
                                    do {
                                        weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                    } catch {
                                        print("Error getting weather: \(error)")
                                    }
                                }
                        }
                    } else {
                        if locationManager.isLoading {
                            LoadingView()
                        } else {
                            WelcomeView()
                                .environmentObject(locationManager)
                        }
                    }
                }
                .padding()
            }
            .preferredColorScheme(.dark)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
