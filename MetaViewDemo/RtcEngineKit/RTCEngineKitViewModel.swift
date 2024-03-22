//
//  RTCEngineKitViewModel.swift
//  MetaViewDemo
//
//  Created by teneocto on 22/03/2024.
//

import ELCore

protocol RTCEngineKitViewModelType: BaseViewModelType {
  var appKey: String { get }

  var channel: String { get }
}

class RTCEngineKitViewModel: RTCEngineKitViewModelType {
  var appKey: String {
    ""
  }

  var channel: String {
    ""
  }

  weak var coordinator: Coordinator?

  init(coordinator: Coordinator?) {
    self.coordinator = coordinator
  }
}

