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
            // Пагинация, подгружает новых персонажей при попадании на последнюю карточку
            guard char.id == vm.characters.last?.id else { return }
            await vm.addNewCharacters()
          }
        }
      }
    }
    .overlay {
      // По текущему запросу результатов не найдено
      if vm.characters.isEmpty {
        ContentUnavailableView.search
          .foregroundStyle(Color.aliveColor)
      }
    }
  }
}

#Preview {
  CharactersScroll(CharactersViewModel())
}
