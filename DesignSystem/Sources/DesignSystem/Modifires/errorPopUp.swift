import SwiftUI

extension View {
  public func errorPopUp(condition: Binding<Bool>) -> some View {
    ZStack {
      self
      
      if condition.wrappedValue {
        Color.black
          .ignoresSafeArea()
          .opacity(0.7)
          .onTapGesture {
            condition.wrappedValue = false
          }
        
        VStack(spacing: 8) {
          Text("Что-то пошло не так…")
            .font(Font.DesignFonts.bold())
          
          Text("Неизвестная ошибка. Но мы не теряем надежды! 🍀")
            .font(Font.DesignFonts.bold())
            .multilineTextAlignment(.center)
            .lineSpacing(3)
            .frame(maxWidth: 260)
          
          SelectableButton(title: "Окей, я понял!", selectedButtonName: "Окей, я понял!") {
            condition.wrappedValue = false
          }
          .padding(.top)
        }
        .padding()
        .padding(.vertical)
        .background(Color.lightGray)
        .clipShape(.rect(cornerRadius: 15))
        .padding(.horizontal, 40)
        .foregroundStyle(.white)
      }
    }
  }
}
