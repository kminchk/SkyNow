import SwiftUICore
import SwiftUI
struct ProvincePickerView: View {
    @Binding var selectedProvince: String
    let provinces = Array(provinceCoordinates.keys)

    var body: some View {
        Picker("จังหวัด", selection: $selectedProvince) {
            ForEach(provinces, id: \.self) { province in
                Text(province)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}
