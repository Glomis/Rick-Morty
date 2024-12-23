import Foundation

/*
 Подготавливаем данные для запроса
 1. Тип получаемых данных
 2. путь ссылки к основному адресу
 3. Метож сетевого запроса
 4. Опцтональные параметры поиска (имя, пол и т.д.)
 */
protocol APIResource {
  associatedtype ModelType: Decodable
  var methodPath: String  { get }
  var httpMethod: HttpMethod { get }
  var filters: [String : String]? { get }
}

extension APIResource {
  var url: URL {
    let mainAdress = "https://rickandmortyapi.com"
    var components = URLComponents(string: mainAdress)!
    components.path = "/api" + methodPath
    
    // Добавляем в ссылку уточняющие параметры
    if let filters {
      components.queryItems = filters.map({URLQueryItem(name: $0.key, value: $0.value)})
    }
    return components.url!
  }
}

//MARK: Метод сетевого запросв
enum HttpMethod: String {
  case get = "GET"
  case post = "POST"
}
