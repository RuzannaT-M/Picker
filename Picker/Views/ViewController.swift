//
//  ViewController.swift
//  Picker
//
//  Created by Ruzanna on 03.08.24.
//

import Combine
import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  @IBOutlet weak var pickerView: UIPickerView!
  
  var viewModel: PickerViewModel!
  
  private var subscriptions = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
    pickerView.reloadAllComponents()
    bind()
  }
}

// MARK: - UIPickerViewDataSource/UIPickerViewDelegate Methods
extension ViewController {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return viewModel.numberOfComponents()
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return viewModel.numberOfRowsInComponent(component: component)
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = UILabel()
    let type = viewModel.type(component: component)
    if type == .dot || type == .space {
      label.text = type.title
    } else {
      label.text = "\(row)"
    }
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 20)
    label.textColor = UIColor(named: "titleColor")
    return label
  }
  
  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return viewModel?.type(component: component).width ?? 0
  }
}

// MARK: - Private Methods
extension ViewController {
    
  private func setValue() {
    for component in  0..<viewModel.numberOfComponents() {
      if case let .digit(value) = viewModel.type(component: component), let rowValue = Int(value) {
        pickerView.selectRow(rowValue, inComponent: component, animated: true)
      }
    }
  }
  
  private func bind() {
    viewModel.outputs.reloadPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.pickerView.reloadAllComponents()
        self?.setValue()
      }.store(in: &subscriptions)
  }
}
