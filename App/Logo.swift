import SwiftUI

struct Logo: View {
    var enabled: Bool

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                let stateColor = enabled ? Color("LogoEnabledColor") : Color("LogoDisabledColor")

                Circle()
                    .stroke(stateColor, lineWidth: 0.1)
                    .position()

                Circle()
                    .foregroundColor(Color.white)

                Circle()
                    .foregroundColor(stateColor)
                    .padding(10)

                Text("Ka-\nBlock!")
                    .textCase(.uppercase)
                    .font(Font.custom("DIN Condensed Bold", size: min(proxy.size.height, proxy.size.width) * 0.25))
                    .shadow(radius: enabled ? 1 : 0, y: 1)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(-45))
            }
        }
        .frame(minWidth: 200, minHeight: 200)
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Logo(enabled: false)
                .preferredColorScheme(.light)
            Logo(enabled: true)
                .preferredColorScheme(.light)
            Logo(enabled: false)
                .preferredColorScheme(.dark)
            Logo(enabled: true)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
