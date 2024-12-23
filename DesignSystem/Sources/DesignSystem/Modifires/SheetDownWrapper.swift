import SwiftUI

public struct SheetDownWrapper: ViewModifier {
  public init() {}
  public func body(content: Content) -> some View {
    content
      .padding(.horizontal, 17)
      .padding(.vertical, 10)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background { Color.lightGray }
      .clipShape(.rect(cornerRadius: 15))
  }
}
