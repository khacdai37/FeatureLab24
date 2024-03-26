//
//  AppCoordinator.swift
//  MetaViewDemo
//
//  Created by teneocto on 22/03/2024.
//

import Foundation
import ELCore

class MainCoordinator: BaseCoordinator {
  override func start(scene: Scene?) {
    // showMain()
    showHeartAnimation()
  }

  private func showMain() {
    var viewController = MainViewController()
    let viewModel = MainViewModel(coordinator: self)
    viewController.bindViewModel(to: viewModel) { view in
      router.push(view)
    }
  }

  override func transition(to scene: Scene) {
    switch scene.name {
    case .RTCEngineKit:
      showRtcEngine()
    case .HeartAnimation:
      showHeartAnimation()
    default:
      super.transition(to: scene)
    }
  }

  private func showRtcEngine() {
    var vc = RTCEngineKitViewController()
    let vm = RTCEngineKitViewModel(coordinator: self)
    vc.bindViewModel(to: vm)
    router.push(vc)
  }

  func showHeartAnimation() {
    var vc = HeartAnimationViewController()
    let vm = HeartAnimationViewModel()
    vc.bindViewModel(to: vm)
    router.push(vc)
  }
}

extension Scene.Name {
  static let RTCEngineKit = Scene.Name(rawValue: "com.abc.RTCEngineKit")
  static let HeartAnimation = Scene.Name(rawValue: "com.abc.HeartAnimation")
}
