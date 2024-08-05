//
//  GetStatisticsUseCase.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

protocol GetStatisticsUseCase {
  func execute(completion: @escaping CompletionValueWithError<Statistics>)
}
