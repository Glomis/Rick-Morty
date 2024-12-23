import SwiftUI
import DesignSystem

struct CharCard: View {
  var char: Character
  @State private var infoIsShown = false
  
  var body: some View {
    VStack(alignment: .leading) {
      CharacterImage()
      
      VStack(alignment: .leading, spacing: 8) {
        Text(char.name)
          .font(.DesignFonts.title())
          .multilineTextAlignment(.leading)
          .modifier(DropdownComponent(isOpened: $infoIsShown))
        
        Components.CharactesInfoView(character: char,
                                     planetColorShame: .grayWhite)
        
        if infoIsShown {
          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dictum aliquam libero, vitae eleifend odio auctor quis. Quisque consequat convallis felis. Vivamus sodales luctus porttitor.")
            .font(.DesignFonts.regular())
            .multilineTextAlignment(.leading)
            .transition(.blurReplace.combined(
              with: .scale(0, anchor: .topLeading)
            ))
        }
      }
      .foregroundStyle(.white)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding([.bottom, .horizontal], 24)
    }
    .background {
      Color.lightGray
    }
    .clipShape(.rect(cornerRadius: 15))
    .task {
      await char.getImage()
    }
  }
  
  //MARK: Изображение персонажа
  @ViewBuilder private func CharacterImage() -> some View {
    if let data = char.imageData {
      Image(uiImage: UIImage(data: data)!)
        .resizable()
        .aspectRatio(1.5, contentMode: .fill)
        .frame(maxHeight: 160)
        .clipped()
    } else {
      ProgressView()
        .tint(.aliveColor)
        .frame(height: 150)
        .frame(maxWidth: .infinity, alignment: .center)
    }
  }
}

#Preview {
  CharCard(char: Character.Moc)
    .padding()
}
