import SwiftUI

struct DropdownComponent: ViewModifier {
  @Binding var isOpened: Bool
  var droppedElements: [String]?
  var selectionAction: (() -> ()?)? = nil
  
  func body(content: Content) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        content
          .frame(maxWidth: .infinity, alignment: .leading)
          .background {
            Color.lightGray
              .opacity(0.01)
          }
        
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
            Button(action: {(selectionAction)?()}, label: {
              Text(element)
                .font(.DesignFonts.semibold())
                .foregroundStyle(.white)
            })
          }
        }
      }
    }
  }
}
