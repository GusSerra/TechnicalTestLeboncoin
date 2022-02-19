//
//  NetworkService.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 19/02/2022.
//

import Foundation

enum NetworkError: Error {
    case RequestError
    case URLError
    case DataParseError
}

struct Resource<T> {
    let baseUrl: String
    let parameters: [String: String]
    let method: String = "GET"
    let parse: (Data) -> T?
}

final class NetworkService {
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T?,NetworkError>) -> ()) {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: resource.baseUrl) {
            
            var queryItems = [URLQueryItem]()
            for parameter in resource.parameters {
                queryItems.append(URLQueryItem(name: parameter.key, value: parameter.value))
            }
            urlComponents.queryItems = queryItems
            
            guard let url = urlComponents.url else {
                completion(.failure(.URLError))
                return
            }

            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                defer {
                  self?.dataTask = nil
                }
                
                if let _ = error {
                    completion(.failure(.RequestError))
                } else if
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 {
                      DispatchQueue.main.async {
                          completion(.success(resource.parse(data)))
                      }
                } else {
                    completion(.failure(.RequestError))
                }
            }
        }
        
        dataTask?.resume()
    }
}
