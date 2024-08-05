//
//  NetworkingProtocol.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

protocol NetworkingProtocol {
  func request(request: APIRequest, completion: CompletionValueWithError<Data>?)
}
