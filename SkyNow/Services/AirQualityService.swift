import Foundation
struct AirQualityService {
    func fetchPM25(lat: Double, lon: Double, completion: @escaping (AirPollutionData?) -> Void) {
        let apiKey = getAPIKey(named: "OpenWeatherApiKey")
        let urlStr = "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"

        guard let url = URL(string: urlStr) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let decoded = try? JSONDecoder().decode(AirPollutionResponse.self, from: data)
            completion(decoded?.list.first)
        }.resume()
    }
}

func getAPIKey(named keyName: String) -> String {
    if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
       let dict = NSDictionary(contentsOfFile: path),
       let apiKey = dict[keyName] as? String {
        return apiKey
    }
    return ""
}
