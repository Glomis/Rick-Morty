import Foundation

// Обертка для декодирования массивов данных
struct Wrapper<T: Decodable>: Decodable {
  let items: [T]
}


class APIRequest<Resource: APIResource>: NetworkRequest {
  let resource: Resource
  
  init(resource: Resource) {
    self.resource = resource
  }
  
  // Расшифровываем полученные данные основываясь на типе модели
  func decode(_ data: Data) async throws -> Resource.ModelType {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    // Сначала проверяем, есть ли ошибка
    if let apiError = try? decoder.decode(APIError.self, from: data) {
      throw apiError // Генерируем кастомную ошибку
    }
    
    // Пытаемся декодировать как одиночный объект
    if let singleItem = try? decoder.decode(Resource.ModelType.self, from: data) {
      return singleItem
    }
    
    // Попробуем сначала декодировать как массив
    if let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data),
       let items = wrapper.items as? Resource.ModelType { return items }
    
    // Выдаем ошибку декодирования
    throw NSError(domain: "APIRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to decode response"])
  }
  
  // Финальный метод по которуму отправляем запрос и получаем готовый ответ
  func execute() async throws -> Resource.ModelType {
    let data = try await load(
      resource.url,
      method: resource.httpMethod
    )
    
    return try await decode(data)
  }
}

// Обработка ошибки сервера
struct APIError: Decodable, Error {
  let message: String
  
  private enum CodingKeys: String, CodingKey {
    case message = "error"
  }
}
