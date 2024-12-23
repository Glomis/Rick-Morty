import SwiftUI
import DesignSystem

struct Splash: View {
  var body: some View {
    ZStack {
      Color.backColor
        .ignoresSafeArea()
      
      VStack(spacing: 20) {
        Image(.logo)
        ProgressView()
          .tint(.aliveColor)
      }
    }
  }
}

#Preview {
  Splash()
}
