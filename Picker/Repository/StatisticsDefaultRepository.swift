//
//  StatisticsDefaultRepository.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Foundation

class StatisticsDefaultRepository {
  
  private let apiDataSource: NetworkingProtocol
  
  init(apiDataSource: NetworkingProtocol) {
    self.apiDataSource = apiDataSource
  }
}

extension StatisticsDefaultRepository: StatisticsRepository {
  
  func getStatistics(completion: @escaping CompletionValueWithError<Statistics>) {
    apiDataSource.request(request: StatisticsRequestProvider().getStatistics()) { response in
      switch response {
      case .success(let data):
        guard let statistics = try? JSONDecoder().decode(Statistics.self, from: data) else {
          completion(.failure(nil))
          return
        }
        completion(.success(statistics))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

struct StatisticsRequestProvider {
  
  private let statisticsPath = "/siteapi/Statistics/GetJackpot"
  
  func getStatistics() -> APIRequest {
    let params = ["LobbyName": 2]
    return APIRequest(method: .get, path: statisticsPath, parameters: params)
  }
}
