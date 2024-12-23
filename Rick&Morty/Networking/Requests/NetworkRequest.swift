import Foundation

/*
 Сетевой запрос который запрашивает тип получаемых данных,
  получает данные с сервера и пытается их расшифровать
  по типу предоставленной модели
 */
protocol NetworkRequest: AnyObject {
  associatedtype ModelType
  func decode(_ data: Data) async throws -> ModelType
  func execute() async throws -> ModelType
}


  // Отправляем запрос и олучаем данные для декодирования
extension NetworkRequest {
   func load(_ url: URL, method: HttpMethod) async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
  }
}
