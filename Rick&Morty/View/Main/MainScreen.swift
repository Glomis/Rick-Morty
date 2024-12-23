import SwiftUI
import DesignSystem

struct MainScreen: View {
  @State var vm = CharactersViewModel()
  @State private var isFirstOpened = false
  @State private var isOpened = false
  private let elements = ["All", "Get Schwifty",
                          "Interdimensional Cable 2: Tempting Fate",
                          "One Crew Over the Crewcoo's Morty"]
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.backColor
          .ignoresSafeArea()
        
        VStack(alignment: .leading, spacing: Paddings.mainPadding) {
          SerchField(text: $vm.name, vm)
          
          ScrollableEpisodes()
          
          StatusSlider(vm: vm)
          
          SpeciesSortButtons(vm)
          
          Components.CharacterPlanetInfo(type: .lastKnown,
                                         detailText: "Nuptia 4",
                                         colorScheme: .whiteGreen)
          .modifier(DropdownComponent(isOpened: $isFirstOpened, droppedElements: elements))
          .modifier(SheetDownWrapper())
          
          Components.CharacterPlanetInfo(type: .lastKnown,
                                         detailText: "Mortynight Run",
                                         colorScheme: .whiteGreen)
          .modifier(DropdownComponent(isOpened: $isOpened, droppedElements: elements))
          .modifier(SheetDownWrapper())
          
          CharactersScroll(vm)
        }
        .padding(.horizontal, Paddings.mainPadding)
      }
      .navigationDestination(for: Character.self) { char in
        CharacterDetailCard(character: char)
      }
    }
    .tint(.aliveColor)
    .overlay {
      if !vm.charactersIsLoaded {
        Splash()
      }
    }
    .errorPopUp(condition: $vm.isUnnownError)
  }
}

#Preview {
  MainScreen()
}
