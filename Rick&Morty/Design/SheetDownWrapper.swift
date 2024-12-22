import SwiftUI

struct SheetDownWrapper: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.horizontal, 17)
      .padding(.vertical, 10)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background { Color.lightGray }
      .clipShape(.rect(cornerRadius: 15))
  }
}

struct DropdownComponent: ViewModifier {
  @Binding var isOpened: Bool
  var droppedElements: [String]?
  var selectionAction: (() -> ()?)? = nil
  
  func body(content: Content) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        content
        Spacer()
        Image(systemName: "control")
          .foregroundStyle(.gray)
          .rotationEffect(Angle(degrees: isOpened ? 180 : 0))
      }
      .onTapGesture {
        withAnimation {
          isOpened.toggle()
        }
      }
      if let droppedElements, isOpened {
        VStack(alignment: .leading, spacing: 12) {
          ForEach(droppedElements, id: \.self) { element in
            Button(action: {(selectionAction!)()}, label: {
              Text(element)
                .font(.headline)
                .foregroundStyle(.white)
            })
          }
        }
      }
    }
  }
}
