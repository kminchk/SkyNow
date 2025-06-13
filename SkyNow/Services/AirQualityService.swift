import Foundation
struct AirQualityService {
    func fetchPM25(lat: Double, lon: Double, completion: @escaping (AirPollutionData?) -> Void) {
        let apiKey = "d9129fe89a4ac4a88883999f239e6064"
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
