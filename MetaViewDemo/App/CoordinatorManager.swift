//
//  File.swift
//  
//
//  Created by Nguyen Khac Dai on 19/01/2024.
//

import Foundation
import ELCore
import ELUIKit
import UIKit

final class CoordinatorManager: CoordinatorManagerProtocol {
  weak var rootCoordinator: Coordinator?

  init() {
  }

  func runNewCoordinator(from coordinator: Coordinator, router: Router, scene: Scene) {
    let fromCoordinator = coordinator
    var targetCoordinator: Coordinator
    let router = router
    if case let .modal(style) = scene.transitionStyle.style {
      let nav = UINavigationController()
      nav.modalTransitionStyle = .crossDissolve
      nav.modalPresentationStyle = style.toUIModalPresentationStyle()
      let moduleRouter = RouterImp(rootController: nav)
      targetCoordinator = createCoordinator(from: scene, with: moduleRouter)
      router.present(nav, animated: scene.transitionStyle.animated)
    } else {
      targetCoordinator = createCoordinator(from: scene, with: router)
    }
    startNewCoordinator(targetCoordinator, from: fromCoordinator, with: scene)
  }
}

extension CoordinatorManager {
  private func startNewCoordinator(_ newCoordinator: Coordinator, from coordinator: Coordinator, with scene: Scene) {
    if var nCoordinator = newCoordinator as? BaseCoordinatorOutputProtocol {
      nCoordinator.finishFlow = { [weak coordinator, weak newCoordinator] in
        coordinator?.removeDependency(newCoordinator)
      }
    }
    coordinator.addDependency(newCoordinator)
    newCoordinator.start(scene: scene)
  }

  private func createCoordinator(from scene: Scene, with router: Router) -> Coordinator {
    switch scene.name {
    case .Main:
      return makeMainCoordinator(router: router)
    default:
      fatalError()
    }
  }

  private func makeMainCoordinator(router: Router) -> Coordinator {
    let coordinator = MainCoordinator(router: router, coordinatorManager: self)
    return coordinator
  }
}

extension ModalPresentationStyle {
  func toUIModalPresentationStyle() -> UIModalPresentationStyle {
    switch self {
    case .currentContext: return .currentContext
    case .overFullScreen: return .overFullScreen
    case .overCurrentContext: return .overCurrentContext
    case .fullScreen: return .fullScreen
    default: return .automatic
    }
  }
}
