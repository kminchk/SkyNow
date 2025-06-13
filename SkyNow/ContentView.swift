import SwiftUI

struct ContentView: View {
    @State private var selectedMode: DisplayMode = .weather
    @State private var selectedProvince = "กรุงเทพมหานคร"
    @State private var currentDate = Date()
    @State private var isDarkMode = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    Text("SkyNow")
                        .font(.largeTitle.bold())
                        .padding(.top)
                    Spacer()
                    ProvincePickerView(selectedProvince: $selectedProvince)
                        .padding(.top)
                }
                .padding(.horizontal)

                ModeSelectorView(selectedMode: $selectedMode)

                Divider()

                if let coords = provinceCoordinates[selectedProvince] {
                    if selectedMode == .weather {
                        WeatherResultView(lat: coords.lat, lon: coords.lon)
                            .id(selectedProvince)
                    } else {
                        PM25ResultView(lat: coords.lat, lon: coords.lon)
                            .id(selectedProvince)
                    }
                }

                Text(formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .onReceive(timer) { input in
                        currentDate = input
                    }

                Spacer()
            }
            .padding()
            Button(action: {
                withAnimation {
                    isDarkMode.toggle()
                }
            }) {
                Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                    .imageScale(.large)
            }
            .padding(.top)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "th_TH")
        formatter.dateFormat = "EEEE d MMMM yyyy เวลา HH:mm"
        return formatter.string(from: currentDate)
    }
}

enum DisplayMode: String, CaseIterable {
    case weather = "สภาพอากาศ"
    case pm25 = "PM2.5"
}

#Preview {
    ContentView()
}
