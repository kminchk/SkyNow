import SwiftUI

struct PM25ResultView: View {
    let lat: Double
    let lon: Double
    @State private var pmData: AirPollutionData?

    var body: some View {
        VStack(spacing: 12) {
            if let data = pmData {
                let pmValue = data.components.pm2_5
                Image(pmIcon(for: pmValue))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)

                Text("\(Int(pmValue)) µg/m³")
                    .font(.system(size: 60, weight: .bold))

                Text(pmStatus(for: pmValue))
                    .font(.title)

            } else {
                ProgressView("กำลังโหลดข้อมูล PM2.5...")
            }
        }
        .padding(.top)
        .onAppear {
            AirQualityService().fetchPM25(lat: lat, lon: lon) { result in
                DispatchQueue.main.async {
                    self.pmData = result
                }
            }
        }
    }

    // ฟังก์ชันกำหนดชื่อภาพตามค่าฝุ่น
    func pmIcon(for value: Double) -> String {
        switch value {
        case 0..<25:
            return "clean-air"     // ใสใน สดชื่น
        case 25..<50:
            return "air-quality"   // ปานกลาง
        default:
            return "warning"       // อันตราย
        }
    }

    // ฟังก์ชันแสดงข้อความสถานะฝุ่น
    func pmStatus(for value: Double) -> String {
        switch value {
        case 0..<25:
            return "อากาศดี"
        case 25..<50:
            return "พอใช้"
        case 50..<100:
            return "เริ่มมีผล"
        default:
            return "อันตราย"
        }
    }
}
