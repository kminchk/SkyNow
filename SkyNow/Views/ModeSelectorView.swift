import SwiftUICore
import SwiftUI
struct ModeSelectorView: View {
    @Binding var selectedMode: DisplayMode
    
    var body: some View {
        Picker("โหมด", selection: $selectedMode) {
            ForEach(DisplayMode.allCases, id: \.self) { mode in
                Text(mode.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
