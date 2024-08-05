//
//  StatisticsRepository.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

protocol StatisticsRepository {
  func getStatistics(completion: @escaping CompletionValueWithError<Statistics>)
}
