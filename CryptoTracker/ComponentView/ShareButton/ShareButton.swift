import SwiftUI
struct ShareButton: View {
    var label: String
    var systemImageName: String
    var action: () -> Void

    init(label: String, systemImageName: String, action: @escaping () -> Void) {
        self.label = label
        self.systemImageName = systemImageName
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: systemImageName)
                    .foregroundColor(.black)
            }
            .padding(.leading, 17)
            .padding(.trailing, 14.55)
            .padding(.vertical, 0)
            .frame(width: 44, height: 32)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.8, green: 0.84, blue: 0.88), lineWidth: 1)
            )
            .background(Color.bg)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ShareButton_Previews: PreviewProvider {
    static var previews: some View {
        ShareButton(label: "Share", systemImageName: "square.and.arrow.up") {
            // Action to be performed on button tap
          
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
