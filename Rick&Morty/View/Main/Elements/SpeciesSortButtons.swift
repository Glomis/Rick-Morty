import SwiftUI
import DesignSystem

struct SpeciesSortButtons: View {
  var vm: CharactersViewModel
  
  init(_ vm: CharactersViewModel) {
    self.vm = vm
  }
  
  //MARK: Кнопки сортировки персонажей по видам
  var body: some View {
    HStack {
      ForEach(Species.allCases, id: \.self) { specie in
        SelectableButton(title: specie.rawValue,
                         selectedButtonName: vm.species.rawValue) {
          vm.species = specie
          Task { await vm.fetchNewCharacters()}
        }
      }
    }
  }
}

#Preview {
  SpeciesSortButtons(CharactersViewModel())
}
