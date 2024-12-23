import SwiftUI

// Модификатор помечающий поле как выдвижной элемент
struct DropdownComponent: ViewModifier {
  @Binding var isOpened: Bool
  var droppedElements: [String]?
  var selectionAction: (() -> ()?)? = nil
  @State private var visibleElements: [String] = []
  
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
      .onTapGesture { withAnimation { isOpened.toggle() } }
      
      // Опциональный список, который выезжает вниз
      if let droppedElements, isOpened {
        VStack(alignment: .leading, spacing: 12) {
          ForEach(droppedElements, id: \.self) { element in
            Button(action: {(selectionAction)?()}, label: {
              Text(element)
                .font(.DesignFonts.semibold())
                .foregroundStyle(.white)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            })
          }
        }
        .onAppear {
          showElementsSequentially()
        }
      }
    }
  }
  
  private func showElementsSequentially() {
    visibleElements = [] // Сбрасываем перед анимацией
    
    guard let droppedElements else { return }
    
    for (index, element) in droppedElements.enumerated() {
              DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.3) {
                  withAnimation {
                      visibleElements.append(element)
                  }
              }
          }
      }
}
