import SwiftUI

struct CharactersScroll: View {
    var vm: CharactersViewModel
  
    init(_ vm: CharactersViewModel) {
      self.vm = vm
    }
  
    var body: some View {
      ScrollView {
        LazyVStack(spacing: 24) {
          ForEach(vm.characters) { char in
            NavigationLink(value: char) {
              CharCard(char: char)
            }
              .task {
                guard char.id == vm.characters.last?.id else { return }
                await vm.addNewCharacters()
              }
          }
        }
      }
      .overlay {
        if vm.characters.isEmpty {
          ContentUnavailableView.search.foregroundStyle(Color.aliveColor)
        }
      }
    }
}

#Preview {
  CharactersScroll(CharactersViewModel())
}
