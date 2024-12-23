import SwiftUI
import DesignSystem

struct CharCard: View {
  var char: Character
  @State private var infoIsShown = false
  private let imageHeight: CGFloat = 160
  
  var body: some View {
    VStack(alignment: .leading) {
      CharacterImage()
      
      VStack(alignment: .leading, spacing: 8) {
        //По тапу на имя открывается доп инфо, по наджатию в любое другое место - переход
        Text(char.name)
          .font(.DesignFonts.title())
          .multilineTextAlignment(.leading)
          .modifier(DropdownComponent(isOpened: $infoIsShown))
        
        Components.CharactesInfoView(character: char,
                                     planetColorShame: .grayWhite)
        
        // Поле скрывается с нарядной анимацией для каждой отдельной карточки
        if infoIsShown {
          Text(detailInfoText)
            .font(.DesignFonts.regular())
            .multilineTextAlignment(.leading)
            .transition(
              .blurReplace.combined(
                with: .scale(0, anchor: .topLeading))
            )
        }
      }
      .foregroundStyle(.white)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding([.bottom, .horizontal], Paddings.mainPadding)
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
        .frame(maxHeight: imageHeight)
        .clipped()
    } else {
      ProgressView()
        .tint(.aliveColor)
        .frame(height: imageHeight)
        .frame(maxWidth: .infinity, alignment: .center)
    }
  }
  
    // Заглушка, т.к нет информации из API
  let detailInfoText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dictum aliquam libero, vitae eleifend odio auctor quis. Quisque consequat convallis felis. Vivamus sodales luctus porttitor."
}

#Preview {
  CharCard(char: Character.Moc)
    .padding()
}
