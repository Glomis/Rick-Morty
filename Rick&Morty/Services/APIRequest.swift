import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String  { get }
  var filters: [String : String]? { get }
    var httpMethod: HttpMethod { get }
}

extension APIResource {
    var url: URL {
      let mainAdress = "https://rickandmortyapi.com"
      var components = URLComponents(string: mainAdress)!
      components.path = "/api" + methodPath
      
      if let filters {
        components.queryItems = filters.map({URLQueryItem(name: $0.key, value: $0.value)})
      }
      
      return components.url!
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Wrapper<T: Decodable>: Decodable {
    let items: [T]
}

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) async throws -> ModelType
    func execute() async throws -> ModelType
}


extension NetworkRequest {
    fileprivate func load(_ url: URL, method: HttpMethod) async throws -> Data {
      let (data, _) = try await URLSession.shared.data(from: url)
//      let strData = String(data: data, encoding: .utf8)!
//      print("DEBUG: Str data = \(url.absoluteString)")
      return data
    }
}

class APIRequest<Resource: APIResource>: NetworkRequest {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
    
    func decode(_ data: Data) async throws -> Resource.ModelType {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Попробуем сначала декодировать как массив
        let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
        
        // Если это массив, возвращаем его
        if let items = wrapper?.items {
            return items as! Resource.ModelType
        }
        
        // Если это одиночный элемент, пытаемся декодировать как одиночный объект
        let singleItem = try? decoder.decode(Resource.ModelType.self, from: data)
        
        // Если это одиночный элемент, возвращаем его
        if let singleItem = singleItem {
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

struct CharacterResource: APIResource {
  var filters: [String : String]? = nil
  
  var httpMethod: HttpMethod
  
  typealias ModelType = Character
    
    var methodPath: String {
      return "/character"
    }
    
    
}

struct CharacterShameResource: APIResource {
  var filters: [String : String]?
  
  var httpMethod: HttpMethod
//  var method: String
  
  typealias ModelType = AllCharacters
    
    var methodPath: String {
      return "/character"
    }
}


