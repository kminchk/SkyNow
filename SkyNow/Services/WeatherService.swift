import Foundation
struct WeatherService {
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (WeatherData?) -> Void) {
        let apiKey = getAPIKey(named: "OpenWeatherApiKey")
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric&lang=th"

        guard let url = URL(string: urlStr) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let decoded = try? JSONDecoder().decode(WeatherData.self, from: data)
            completion(decoded)
        }.resume()
    }
}
