//
//  PickerViewModeling.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import Combine
import Foundation

protocol PickerViewModeling {
  var inputs: PickerViewModelInputs { get }
  var outputs: PickerViewModelOutputs { get set }
}

protocol PickerViewModelInputs {
  func viewDidLoad()
}

protocol PickerViewModelOutputs {
  var reloadPublisher: PassthroughSubject<Void, Never> { get set }
  func numberOfComponents() -> Int
  func numberOfRowsInComponent(component: Int) -> Int
  func type(component: Int) -> ComponentType
}
