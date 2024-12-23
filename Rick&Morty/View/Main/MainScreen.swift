import SwiftUI
import DesignSystem

struct MainScreen: View {
  @State var vm = CharactersViewModel()
  @State private var isFirstOpened = false
  @State private var isOpened = false
  private let elements = ["All", "Get Schwifty",
                  "Interdimensional Cable 2: Tempting Fate",
                  "One Crew Over the Crewcoo's Morty"]
  let images = ["sroll1", "sroll2", "sroll3"]

  var body: some View {
    NavigationStack {
      ZStack {
        Color.backColor
          .ignoresSafeArea()
        
        VStack(alignment: .leading, spacing: 24) {
          SerchField(text: $vm.name, vm)
          
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
                                      spacing: 0)
            }
          }
          .scrollTargetBehavior(.paging)
          .frame(height: 100)
          .padding(.horizontal, -24)
          
          GenderSortButtons(vm)
          
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
        .padding(.horizontal, 24)
      }
      .navigationDestination(for: Character.self) { char in
        CharacterDetailCard(character: char)
      }
    }
    .tint(.aliveColor)
    .overlay {
      Splash()
    }
  }
}

#Preview {
  MainScreen()
}
