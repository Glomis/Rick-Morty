import SwiftUI
import DesignSystem

struct GenderSortButtons: View {
    var vm: CharactersViewModel
  
  init(_ vm: CharactersViewModel) {
    self.vm = vm
  }
  
    var body: some View {
      HStack {
        ForEach(CharStatus.allCases, id: \.self) { status in
          SelectableButton(title: status.rawValue,
                           selectedButtonName: vm.status) {
            vm.status = status.rawValue
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
