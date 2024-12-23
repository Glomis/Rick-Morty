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
          
          Text(description)
            .font(.DesignFonts.regular())
            .multilineTextAlignment(.leading)
            .foregroundStyle(.white)
            .padding(.top, Paddings.mainPadding)
        }
        .padding(Paddings.mainPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .navigationTitle(character.name)
    .task {
      await character.getImage()
    }
  }
  
  let description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dictum aliquam libero, vitae eleifend odio auctor quis. Quisque consequat convallis felis. Vivamus sodales luctus porttitor. Nulla lacinia dapibus lectus sed commodo. Duis faucibus at tortor ut tincidunt. Aliquam nibh purus, imperdiet eget gravida non, scelerisque nec dolor. Donec facilisis neque vel ipsum malesuada venenatis. Proin vel lectus maximus, viverra turpis in, scelerisque dui. Duis at elit felis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec sapien ante. Duis ac odio id nibh laoreet mattis. Pellentesque id ultrices lacus. Aenean ac rutrum est, hendrerit varius purus."
}

#Preview {
  CharacterDetailCard(character: Character.Moc)
}
