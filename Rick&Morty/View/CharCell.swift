import SwiftUI

struct CharCell: View {
  var char: Character
  @State private var infoIsShown = false
  
  var body: some View {
    VStack(alignment: .leading) {
      CharacterImage()
      
      VStack(alignment: .leading, spacing: 8) {
        Text(char.name)
          .font(.title)
          .modifier(DropdownComponent(isOpened: $infoIsShown))
        
        Components.CharactesInfoView(character: char,
                                     planetColorShame: .grayWhite)
        
        if infoIsShown {
          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dictum aliquam libero, vitae eleifend odio auctor quis. Quisque consequat convallis felis. Vivamus sodales luctus porttitor.")
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
      await self.getImage()
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
        .frame(height: 150)
    }
  }
  
  //MARK: Загрузка картинки
  private func getImage() async {
    guard char.imageData == nil else { return }
    guard let url = URL(string: char.image) else { return}
    char.imageData = try? await URLSession.shared.data(from: url).0
  }
}

#Preview {
  CharCell(char: Character.Moc)
    .padding()
}
