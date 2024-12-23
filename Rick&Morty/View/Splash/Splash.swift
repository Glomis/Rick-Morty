import SwiftUI
import DesignSystem

struct Splash: View {
    var body: some View {
      ZStack {
        Color.backColor
          .ignoresSafeArea()
        
        VStack {
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
