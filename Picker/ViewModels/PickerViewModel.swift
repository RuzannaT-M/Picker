//
//  PickerViewModel.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Combine
import Foundation

extension PickerViewModel {
  enum Constants {
    static let digitsBatchCount = 3
    static let dataFetchTimeInterval = 6.0
    static let uiUpdateTimeInterval = 1.0
  }
}

class PickerViewModel: PickerViewModeling, PickerViewModelInputs, PickerViewModelOutputs {

  private let getStatisticsUseCase: GetStatisticsUseCase

  var inputs: PickerViewModelInputs { return self }
  var outputs: PickerViewModelOutputs {
    get { return self }
    set {}
  }
  
  var reloadPublisher = PassthroughSubject<Void, Never>()
  
  // MARK: - Private properties
  private var currentValue = 0.00
  private var uiTimer: Timer?
  private var dataTimer: Timer?
  private var diff: Double = 0
  private var statistics: Statistics?

  init(getStatisticsUseCase: GetStatisticsUseCase) {
    self.getStatisticsUseCase = getStatisticsUseCase
  }
}

//MARK: Inputs
extension PickerViewModel {

  func viewDidLoad() {
    updateData()
    
    uiTimer = Timer.scheduledTimer(withTimeInterval: Constants.uiUpdateTimeInterval, repeats: true) { [weak self] _ in
      guard let self else { return }
      self.currentValue += self.diff
      let statisticsValue = self.statistics?.spades.current ?? 0.0
      if self.currentValue >= statisticsValue {
        self.currentValue = statisticsValue
        self.diff = 0
      }
      self.reloadPublisher.send()
    }
    
    dataTimer = Timer.scheduledTimer(withTimeInterval: Constants.dataFetchTimeInterval, repeats: true) { [weak self] _ in
      self?.updateData()
    }
  }
}

// MARK: - Outputs
extension PickerViewModel {
  
  func numberOfComponents() -> Int {
    return stringValue(of: currentValue).count
  }
  
  func numberOfRowsInComponent(component: Int) -> Int {
    return type(component: component).count
  }
  
  func type(component: Int) -> ComponentType {
    let stringValue = stringValue(of: currentValue)
    
    if let item = stringValue.characterAt(index: component) {
      if item == "." {
        return .dot
      } else if item == " " {
        return .space
      } else {
        return .digit(value: "\(item)")
      }
    }
    return .space
  }
}

// MARK: - Private Methods
extension PickerViewModel {
  
  private func updateData() {
    getStatisticsUseCase.execute { [weak self] response in
      guard let self else { return }
      switch response {
      case .success(let statistics):
        self.currentValue = self.statistics?.spades.current ?? 0
        self.statistics = statistics
        if self.currentValue == 0 {
          self.currentValue = statistics.spades.current
        } else {
          self.diff = (statistics.spades.current - self.currentValue)/Constants.dataFetchTimeInterval
        }
      case .failure(_):
        break
      }
    }
  }
  
  private func stringValue(of value: Double) -> String {
    let digitsAfterPoint = statistics?.digitsAfterPoint ?? 2
    let numberString = String(format: "%.\(digitsAfterPoint)f", value)
    var newStr = ""
    for (index, character) in numberString.reversed().enumerated() {
      newStr.insert(character, at: newStr.startIndex)
      if index != digitsAfterPoint &&
          index != numberString.count - 1 &&
          (index - digitsAfterPoint)%Constants.digitsBatchCount == 0 {
        newStr.insert(" ", at: newStr.startIndex)
      }
    }
    return newStr
  }
}
