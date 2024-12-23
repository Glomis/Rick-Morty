import Foundation

class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> Data? {
        return data
    }
    
  func execute() async throws -> Data? {
      try await load(url, method: .get)
    }
}
