//
//  DemoViewModel.swift
//  MetaViewDemo
//
//  Created by teneocto on 22/03/2024.
//

import Foundation
import Combine
import ELCore

protocol MainViewModelType: BaseViewModelType {
  var onDataChanged: AnyPublisher<[FeatureApp], Never> { get }

  var features: [FeatureApp] { get }
}

class MainViewModel: MainViewModelType {
  weak var coordinator: Coordinator?

  private let data: CurrentValueSubject<[FeatureApp], Never>

  init(coordinator: Coordinator? = nil) {
    self.coordinator = coordinator
    data = CurrentValueSubject(FeatureApp.allCases)
  }

  var onDataChanged: AnyPublisher<[FeatureApp], Never> {
    data.eraseToAnyPublisher()
  }

  var features: [FeatureApp] {
    data.value
  }
}

