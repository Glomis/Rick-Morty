import UIKit
import CoreGraphics
import CoreText

// Фатальная ошибка регистрации шрифтов
public enum FontError: Swift.Error {
  case failedToRegisterFont
}

// Регистрации шрифтов из дизайн модели
public func registerFont(named name: String) throws {
  guard let asset = NSDataAsset (name: "Fonts/\(name)", bundle: Bundle.module),
        let provider = CGDataProvider(data: asset.data as NSData),
        let font = CGFont (provider),
        CTFontManagerRegisterGraphicsFont (font, nil ) else {
    throw FontError.failedToRegisterFont
  }
}
