import Foundation

protocol NetworkRequest: AnyObject {
  associatedtype ModelType
  func decode(_ data: Data) async throws -> ModelType
  func execute() async throws -> ModelType
}


extension NetworkRequest {
  func load(_ url: URL, method: HttpMethod) async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
  }
}
