import SwiftUI
import DesignSystem

struct StatusSlider: View {
  var vm: CharactersViewModel
  @Namespace var namespace
  
  var body: some View {
    HStack {
      ForEach(CharStatus.allCases, id: \.self) { status in
        Button { statusSelect(status) } label: { StatusButtonLable(status) }
      }
    }
    .modifier(SheetDownWrapper())
  }
  
  // Лейбл кнопки с анимированным задним фоном
  @ViewBuilder func StatusButtonLable(_ status: CharStatus) -> some View {
    Text(status.rawValue.capitalized)
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
  
    //MARK: Метод надатия на кнопку
  func statusSelect(_ status: CharStatus) {
    withAnimation { vm.status = status }
    Task { await vm.fetchNewCharacters() }
  }
}

#Preview {
  StatusSlider(vm: CharactersViewModel())
    .padding(30)
}
