//
//  Networking.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

typealias CompletionValueWithError<T> = (_ response: Response<T>) -> Void

enum Response<T> {
  case success(T)
  case failure(Error?)
}

//MARK: - NetworkingProtocol Methods
class Networking: NetworkingProtocol {
  
  func request(request: APIRequest, completion: CompletionValueWithError<Data>?) {
    performRequest(request: request.urlRequest(), completion: completion)
  }
}

//MARK: - Private Methods
extension Networking {
  
  private func performRequest(request: URLRequest, completion: CompletionValueWithError<Data>?) {
    let dataTask = URLSession(configuration: .ephemeral).dataTask(with: request) {(data, response, error) in
      guard error == nil else {
        completion?(.failure(error))
        return
      }
      
      guard let response = response as? HTTPURLResponse else { fatalError() }
      
      guard (200...299).contains(response.statusCode) else {
        completion?(.failure(nil))
        return
      }
      
      if let data = data {
        completion?(.success(data))
        return
      }
      completion?(.failure(nil))
    }
    dataTask.resume()
  }
}
