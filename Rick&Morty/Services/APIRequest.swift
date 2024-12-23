import Foundation

struct Wrapper<T: Decodable>: Decodable {
  let items: [T]
}

class APIRequest<Resource: APIResource>: NetworkRequest {
  let resource: Resource
  
  init(resource: Resource) {
    self.resource = resource
  }
  
  func decode(_ data: Data) async throws -> Resource.ModelType {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    // Сначала проверяем, есть ли ошибка
    if let apiError = try? decoder.decode(APIError.self, from: data) {
      throw apiError // Генерируем кастомную ошибку
    }
    
    // Попробуем сначала декодировать как массив
    if let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data),
       let items = wrapper.items as? Resource.ModelType {
      return items
    }
    
    // Пытаемся декодировать как одиночный объект
    if let singleItem = try? decoder.decode(Resource.ModelType.self, from: data) {
      return singleItem
    }
    
    throw NSError(domain: "APIRequest", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to decode response"])
  }
  
  func execute() async throws -> Resource.ModelType {
    let data = try await load(
      resource.url,
      method: resource.httpMethod
    )
    return try await decode(data)
  }
}

struct CharacterShameResource: APIResource {
  typealias ModelType = AllCharacters
  var methodPath = "/character"
  var httpMethod: HttpMethod = .get
  var filters: [String : String]?
}



struct APIError: Decodable, Error {
  let message: String
  
  private enum CodingKeys: String, CodingKey {
    case message = "error"
  }
}
