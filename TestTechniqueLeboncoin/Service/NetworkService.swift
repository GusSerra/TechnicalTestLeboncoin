//
//  NetworkService.swift
//  TestTechniqueLeboncoin
//
//  Created by Gustavo Serra on 19/02/2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T?,NetworkError>) -> ())
}

enum NetworkError: Error {
    case RequestError
    case URLError
    case DataParseError
}

struct Resource<T> {
    let baseUrl: String
    let parse: (Data) -> T?
}

final class NetworkService: NetworkServiceProtocol {
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T?,NetworkError>) -> ()) {
        
        dataTask?.cancel()
        
        if let urlComponents = URLComponents(string: resource.baseUrl) {
            
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
