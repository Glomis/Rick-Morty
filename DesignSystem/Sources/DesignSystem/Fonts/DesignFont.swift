import SwiftUI

// 
public struct DesignFont {
  public let name: String
  
  private init(named name: String) {
    self.name = name
    do {
      try registerFont(named: name)
    } catch {
      let reason = error.localizedDescription
      fatalError ("Не удалось зарегистрировать шрифт: \(reason)")
    }
  }
  
  public static let light = DesignFont(named: "Montserrat-Thin")
  public static let regular = DesignFont(named: "Montserrat-Regular")
  public static let bold = DesignFont(named: "Montserrat-Bold")
}


extension Font {
  public struct DesignFonts {
    public static func title() -> Font {
      return Font.custom(DesignFont.bold.name, fixedSize: 24)
    }
    
    public static func bold() -> Font {
      return Font.custom(DesignFont.bold.name, fixedSize: 12)
    }
    
    public static func semibold() -> Font {
      return Font.custom(DesignFont.bold.name, fixedSize: 12)
    }
    
    public static func anotation() -> Font {
      return Font.custom(DesignFont.bold.name, fixedSize: 8)
    }
    
    public static func regular() -> Font {
      return Font.custom(DesignFont.regular.name, size: 12)
    }
  }
}



