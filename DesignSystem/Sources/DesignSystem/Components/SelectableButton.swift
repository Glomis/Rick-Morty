import SwiftUI

// Повторяющийся элемент кнопки с выбором параметра поиска
public struct SelectableButton: View {
  var title: String
  var selectedButtonName: String
  var action: () -> ()
  
  public init(title: String, selectedButtonName: String, action: @escaping () -> Void) {
    self.title = title
    self.selectedButtonName = selectedButtonName
    self.action = action
  }
  
  // Для читаемости кода
  var isSelected: Bool {
    selectedButtonName == title
  }
  
  public var body: some View {
    Button {
      action()
    } label: {
      Text(title.capitalized)
        .font(.DesignFonts.bold())
        .padding(.vertical, 8.5)
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.aliveColor : Color.lightGray)
        .foregroundColor(isSelected ? Color.backColor : Color.white)
        .clipShape(.rect(cornerRadius: 10))
    }
  }
}

#Preview {
  SelectableButton(title: "Hello", selectedButtonName: "dd") { }
    .padding()
}
