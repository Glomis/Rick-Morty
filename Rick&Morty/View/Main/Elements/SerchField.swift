import SwiftUI
import DesignSystem

struct SerchField: View {
  @Binding var text: String
  var vm: CharactersViewModel
  
  init(text: Binding<String>, _ vm: CharactersViewModel) {
    self._text = text
    self.vm = vm
  }
  
  //MARK: Кастомный TextField
  var body: some View {
    HStack {
      ZStack(alignment: .leading) {
        Text("Search by name")
          .font(.DesignFonts.semibold())
          .scaleEffect(text.isEmpty ? 1 : 0.6, anchor: .leading)
          .offset(y: text.isEmpty ? 0 : -8)
        
        // При наборе создает запрос с фильтром по имени
        TextField("", text: $text)
          .font(.DesignFonts.semibold())
          .onChange(of: text) { _, _ in
            Task { await vm.fetchNewCharacters() }
          }
          .foregroundStyle(Color.aliveColor)
          .padding(.vertical, 5)
          .offset(y: text.isEmpty ? 0 : 5)
      }
      .animation(.linear, value: text)
      
      Image(systemName: "magnifyingglass")
        .resizable()
        .scaledToFill()
        .frame(width: 18, height: 18)
    }
    .foregroundStyle(.white)
    .modifier(SheetDownWrapper())
  }
}

#Preview {
  SerchField(text: .constant("Hello"), CharactersViewModel())
}
