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
