//
//  APIRequest.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

//MARK: - Enums
public enum RequestMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
  case patch = "PATCH"
}

public struct APIRequest {
  
  private let baseURL = "betera.centrivo.pm"
  
  //MARK: - Private Properties
  private let method: RequestMethod
  private let path: String
  private let parameters: [String: Any?]?
  
  public init(method: RequestMethod,
              path: String,
              parameters: [String: Any?]? = nil) {
    self.method = method
    self.path = path
    self.parameters = parameters
  }
  
  // MARK: - Public Methods
  func urlRequest() -> URLRequest {
    var component = URLComponents()
    component.scheme = "https"
    component.host = baseURL
    component.path = path
    component.queryItems = getQueryParameters(parameters)

    var urlRequest = URLRequest(url: component.url!)
    urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    urlRequest.httpMethod = method.rawValue
    return urlRequest
  }
  
  // MARK: - Private Methods
  private func getQueryParameters(_ parameters: [String: Any?]?) -> [URLQueryItem] {
    var queries = [URLQueryItem]()
    if let values = parameters {
      values.forEach { (key, value) in

        if let value = value {

          if let array = value as? [String] {
            array.forEach {
              let query = URLQueryItem(name: key, value: "\($0)")
              queries.append(query)
            }
          } else {
            let query = URLQueryItem(name: key, value: "\(value)")
            queries.append(query)
          }
        }
      }
    }
    return queries
  }
}
