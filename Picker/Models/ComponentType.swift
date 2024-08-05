//
//  ComponentType.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

enum ComponentType: Equatable {
  
  case digit(value: String)
  case dot
  case space
  
  var title: String {
    switch self {
    case let .digit(value):
      return value
    case .dot:
      return "."
    case .space:
      return " "
    }
  }
  
  var count: Int {
    switch self {
    case .digit(_):
      return 10
    case .dot, .space:
      return 1
    }
  }
  
  var width: CGFloat {
    switch self {
    case .digit(_):
      return 12
    case .dot, .space:
      return 4
    }
  }
}
