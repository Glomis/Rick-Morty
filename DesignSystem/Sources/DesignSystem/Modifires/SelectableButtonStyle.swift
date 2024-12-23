import SwiftUI

public struct SelectableButtonStyle: ButtonStyle {
  @Binding var isSelected: Bool
  
  public init(isSelected: Binding<Bool>) {
    self._isSelected = isSelected
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.vertical, 8.5)
      .frame(maxWidth: .infinity)
      .background(isSelected ? Color.green : Color.gray)
      .foregroundColor(isSelected ? Color.gray : Color.white)
      .overlay {
        configuration.isPressed ? Color.black.opacity(0.5) : nil
      }
      .clipShape(.rect(cornerRadius: 10))
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
  }
}

extension Button {
  public func selectable(isSelected: Binding<Bool>) -> some View {
    self.buttonStyle(SelectableButtonStyle(isSelected: isSelected))
  }
}
