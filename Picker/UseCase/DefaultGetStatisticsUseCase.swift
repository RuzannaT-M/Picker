//
//  DefaultGetStatisticsUseCase.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

class DefaultGetStatisticsUseCase {
  
  private let repository: StatisticsRepository
  
  init(with repository: StatisticsRepository) {
    self.repository = repository
  }
}

extension DefaultGetStatisticsUseCase: GetStatisticsUseCase {
  
  func execute(completion: @escaping CompletionValueWithError<Statistics>) {
    return repository.getStatistics(completion: completion)
  }
}
