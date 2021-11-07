import SwiftUI

struct HomeScreen: View {
    var isEnabled: Bool

    var body: some View {
        GeometryReader { proxy in
            VStack {
                Logo(enabled: isEnabled)
                    .padding()
                    .padding(.vertical, 20.0)
                    .background(Color("UpperBackgroundColor"))

                Text(isEnabled ? "instructions-enabled" : "instructions-disabled")
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(height: proxy.size.height / 3)
            }
            .background(Color("LowerBackgroundColor"))
        }
        .ignoresSafeArea()
    }
}

@available(macOS 12.0, *)
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeScreen(isEnabled: false)
                .preferredColorScheme(.light)
            HomeScreen(isEnabled: true)
                .preferredColorScheme(.light)
            HomeScreen(isEnabled: false)
                .preferredColorScheme(.dark)
            HomeScreen(isEnabled: true)
                .preferredColorScheme(.dark)

            HomeScreen(isEnabled: true)
                .preferredColorScheme(.light)
                .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        }
        .previewLayout(.device)
    }
}
