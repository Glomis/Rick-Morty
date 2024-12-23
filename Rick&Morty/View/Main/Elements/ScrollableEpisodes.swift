import SwiftUI
import DesignSystem

struct ScrollableEpisodes: View {
  private let images = ["sroll1", "sroll2", "sroll3"]
  
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(images, id: \.self) { image in
            Image(image)
              .resizable()
              .scaledToFill()
              .frame(width: UIScreen.main.bounds.width)
              
          }
          .containerRelativeFrame(.horizontal,
                                  count: 1,
                                  spacing: -10)
        }
      }
      .scrollTargetBehavior(.paging)
      .frame(height: 100)
      .padding(.horizontal, -Paddings.mainPadding)
    }
}

#Preview {
    ScrollableEpisodes()
}
