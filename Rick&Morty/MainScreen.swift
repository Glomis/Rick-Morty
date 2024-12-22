import SwiftUI

struct MainScreen: View {
  @State var vm = CharactersViewModel()
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.backColor
          .ignoresSafeArea()
        
        VStack(alignment: .leading, spacing: 24) {
          Components.CharacterPlanetInfo(type: .lastKnown,
                                         detailText: "Nuptia 4", colorScheme: .whiteGreen)
          .padding(.horizontal, 17)
          .padding(.vertical, 10)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background { Color.lightGray }
          .clipShape(.rect(cornerRadius: 15))
          
          Components.CharacterPlanetInfo(type: .lastKnown,
                                         detailText: "Mortynight Run", colorScheme: .whiteGreen)
          .padding(.horizontal, 17)
          .padding(.vertical, 10)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background { Color.lightGray}
          .clipShape(.rect(cornerRadius: 15))
          
          ScrollView {
            LazyVStack(spacing: 24) {
              ForEach(vm.characters) { char in
                CharCell(char: char)
                  .task {
                    guard char.id == vm.characters.last?.id else { return }
                    await vm.getCharacters()
                  }
              }
            }
          }
        }
        .padding(.horizontal, 24)
      }
      .task { await vm.getCharacters() }
    }
  }
}

#Preview {
  MainScreen()
}
