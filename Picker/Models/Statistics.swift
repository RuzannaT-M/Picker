//
//  Statistics.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

struct Statistics: Codable {
  
  var digitsAfterPoint: Int
  var spades: Card
}

extension Statistics {
  struct Card: Codable {
    let current: Double
  }
}
