struct AirPollutionResponse: Decodable {
    let list: [AirPollutionData]
}

struct AirPollutionData: Decodable {
    let main: AQI
    let components: Components
    
    var aqi: Int { main.aqi }
}

struct AQI: Decodable {
    let aqi: Int
}

struct Components: Decodable {
    let pm2_5: Double
    let pm10: Double
}
