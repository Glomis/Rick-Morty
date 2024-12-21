import SwiftUI

struct Main: View {
  @State var vm = CharactersViewModel()
  
    var body: some View {
      NavigationStack {
        ZStack {
          Colors.blackColor
            .ignoresSafeArea()
          
          List(vm.characters) { char in
            CharCell(char: char)
              .task {
                guard char.id == vm.characters.last?.id else { return }
                await vm.getCharacters()
              }
          }
        }
        .task {
         await vm.getCharacters()
        }
      }
    }
}

#Preview {
    Main()
}
