import SwiftUI

struct WeatherResultView: View {
    let lat: Double
    let lon: Double
    @State private var weatherData: WeatherData?

    var body: some View {
        VStack(spacing: 12) {
            if let data = weatherData {
                Text("📍 " + data.name)
                .font(.title)

                Image(iconName(for: data.weather.first?.main ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)

                Text("\(Int(data.main.temp))°")
                    .font(.system(size: 72, weight: .bold))
              
                Text(data.weather.first?.description.capitalized ?? "")
                    .font(.title)

            } else {
                ProgressView("กำลังโหลดสภาพอากาศ...")
            }
        }
        .padding(.top)
        .onAppear {
            WeatherService().fetchWeather(lat: lat, lon: lon) { result in
                DispatchQueue.main.async {
                    self.weatherData = result
                }
            }
        }
    }

    // ฟังก์ชันเลือกชื่อภาพจาก weather.main
    func iconName(for condition: String) -> String {
        switch condition.lowercased() {
        case "clear":
            return "sunny"
        case "clouds":
            return "cloudy"
        case "rain", "drizzle", "thunderstorm":
            return "storm"
        case "snow", "mist", "fog":
            return "cloudy"
        default:
            return "cloudy"
        }
    }
}
