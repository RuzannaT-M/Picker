//
//  AppCoordinator.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import UIKit
import Foundation

public final class AppCoordinator: NSObject {
  
  static let `default`: AppCoordinator = {
    return AppCoordinator()
  }()
  
  // MARK: - Public Methods
  func start() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window = window
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
      let repository = StatisticsDefaultRepository(apiDataSource: Networking())
      let useCase = DefaultGetStatisticsUseCase(with: repository)
      vc.viewModel = PickerViewModel(getStatisticsUseCase: useCase)
      
      appDelegate.window?.rootViewController = vc
      appDelegate.window?.makeKeyAndVisible()
    } else {
      print("ViewController with identifier 'ViewController' not found")
    }
  }
  
  // MARK: - Private Methods
  private override init() {}
}
