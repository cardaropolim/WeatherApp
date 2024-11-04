import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody

    var body: some View {
        // Calcul des températures en Celsius
        let temperatureCelsius = weather.main.temp - 273.15
        let minTemperatureCelsius = weather.main.tempMin - 273.15
        let maxTemperatureCelsius = weather.main.tempMax - 273.15
        let kmhwindspeed =  weather.wind.speed * 3.6

        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                        .foregroundColor(Color(hue: 0.626, saturation: 0.715, brightness: 0.965))

                    Text("Today, \(Date().formatted(.dateTime.day().month(.wide).year().hour().minute()))")
                        .bold()
                        .fontWeight(.light)
                        .foregroundColor(Color(hue: 0.626, saturation: 0.715, brightness: 0.965))
                        
                    

                    Spacer()

                    HStack(spacing: 20) {
                        Image(systemName: "sun.max.fill")
                            .font(.system(size: 40))

                        Text(weather.weather[0].main)
                            .font(.title2)
                            .padding(.bottom, 5)

                        Text("\(String(format: "%.1f", temperatureCelsius)) °C")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                    }
                    .foregroundColor(Color(hue: 0.626, saturation: 0.715, brightness: 0.965))
                    .frame(maxWidth: .infinity)

                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                            .padding(.bottom, 20)
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
                
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                        .padding(.horizontal)
                        .padding(.top)
                    Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
                        GridRow {
                            WeatherRow(
                                logo: "thermometer.low",
                                name: "Min temp",
                                value: "\(String(format: "%.0f", minTemperatureCelsius)) °C"
                            )
                            .padding(.horizontal)
                            
                            WeatherRow(
                                logo: "thermometer.high",
                                name: "Max temp",
                                value: "\(String(format: "%.0f", maxTemperatureCelsius)) °C"
                            )
                            .padding(.horizontal)
                        }
                        
                        GridRow {
                            WeatherRow(
                                logo: "wind",
                                name: "Wind speed",
                                value: "\(String(format: "%.0f", kmhwindspeed)) km/h"
                            )
                            .padding(.horizontal)
                            
                            WeatherRow(
                                logo: "humidity",
                                name: "Humidity",
                                value: "\(String(format: "%.0f", (weather.main.humidity))) %"
                            )
                            .padding(.horizontal)
                        }
                    }
                }
                    
                    .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 60)
                .foregroundColor(Color(hue: 0.626, saturation: 0.715, brightness: 0.965))
                .background(Color(hue: 0.603, saturation: 0.032, brightness: 0.944))
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.603, saturation: 0.127, brightness: 0.913))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
