import SwiftUI
import DesignSystem

struct StatusSlider: View {
  var vm: CharactersViewModel
  @Namespace var namespace
  
  var body: some View {
    HStack {
      ForEach(CharStatus.allCases, id: \.self) { status in
        Button {
          withAnimation {
            vm.status = status
          }
          Task {
            await vm.fetchNewCharacters()
          }
        } label: {
          Text(status.rawValue.capitalized)
        }
        .frame(maxWidth: .infinity)
        .font(.DesignFonts.bold())
        .padding(.vertical, 8.5)
        .frame(maxWidth: .infinity)
        .background {
          if vm.status == status {
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.aliveColor)
              .matchedGeometryEffect(id: "ID", in: namespace)
          }
        }
        .foregroundColor(vm.status == status ? Color.backColor : Color.white)
      }
    }
    .modifier(SheetDownWrapper())
  }
}

#Preview {
  StatusSlider(vm: CharactersViewModel())
    .padding(30)
}
