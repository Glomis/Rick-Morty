import SwiftUI
import DesignSystem

struct GenderSortButtons: View {
    var vm: CharactersViewModel
  
  enum Species: String, CaseIterable {
    case alien, human, robot
  }
  
  init(_ vm: CharactersViewModel) {
    self.vm = vm
  }
  
  //MARK: Кнопки сортировки персонажей по разновидности
    var body: some View {
      HStack {
        ForEach(Species.allCases, id: \.self) { specie in
          SelectableButton(title: specie.rawValue,
                           selectedButtonName: vm.species) {
            vm.species = specie.rawValue
            Task {
              await vm.fetchNewCharacters()
            }
          }
        }
      }
    }
}

#Preview {
  GenderSortButtons(CharactersViewModel())
}
