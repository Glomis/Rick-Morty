import SwiftUI
import DesignSystem

struct CharacterDetailCard: View {
  let character: Character
  
  private let imageWidth = UIScreen.main.bounds.width
  @State private var imageHeight: CGFloat = 250
  
  var body: some View {
    ZStack {
      Color.backColor
        .ignoresSafeArea()
      
      ScrollView(showsIndicators: false) {
        GeometryReader { proxy in
          Image(uiImage: UIImage(data: character.imageData ?? Data()) ?? UIImage())
            .resizable()
            .aspectRatio(1.3, contentMode: .fill)
            .padding(.top, 40)
            .frame(width: imageWidth, height: abs(proxy.frame(in: .global).minY + imageHeight))
            .offset(y: -proxy.frame(in: .global).minY)
        }
        .frame(height: imageHeight)
        
        VStack(alignment: .leading) {
          Components.CharactesInfoView(character: character,
                                       planetColorShame: .white)
          
          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dictum aliquam libero, vitae eleifend odio auctor quis. Quisque consequat convallis felis. Vivamus sodales luctus porttitor.")
            .font(.DesignFonts.regular())
            .multilineTextAlignment(.leading)
            .foregroundStyle(.white)
            .padding(.top, 24)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .navigationTitle(character.name)
    .task {
      await character.getImage()
    }
  }
}

#Preview {
  CharacterDetailCard(character: Character.Moc)
}
