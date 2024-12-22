import SwiftUI

struct CharacterDetailView: View {
  let character: Character
  
    var body: some View {
      ZStack {
        Color.backColor
          .ignoresSafeArea()
        VStack {
          ScrollView {
            VStack(alignment: .leading) {
              Image(uiImage: UIImage(data: character.imageData ?? Data()) ?? UIImage())
              
              Text(character.type)
              
              Components.CharactesInfoView(character: character,
                                           planetColorShame: .white)
              
              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dictum aliquam libero, vitae eleifend odio auctor quis. Quisque consequat convallis felis. Vivamus sodales luctus porttitor.")
                .multilineTextAlignment(.leading)
                .foregroundStyle(.white)
                .padding(.top, 24)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
      }
    }
}

#Preview {
  CharacterDetailView(character: Character.Moc)
}
