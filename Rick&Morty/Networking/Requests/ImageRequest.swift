import Foundation

  // Запрос на получаение картинки
class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

// Изменяем декодируемые данные на Дату, чтобы преобразовать ее в изображение
extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> Data? {
        return data
    }
    
  func execute() async throws -> Data? {
      try await load(url, method: .get)
    }
}
