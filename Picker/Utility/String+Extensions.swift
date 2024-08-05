//
//  String+Extensions.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

extension String {
  
  func characterAt(index: Int) -> Character? {
    guard index >= 0 && index < count else { return nil }
    let stringIndex = self.index(startIndex, offsetBy: index)
    return self[stringIndex]
  }
}
