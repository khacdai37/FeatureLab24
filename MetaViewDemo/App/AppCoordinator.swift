//
//  File.swift
//
//
//  Created by Nguyen Khac Dai on 18/01/2024.
//

import ELCore
import ELUIKit
import UIKit

public class AppCoordinator: BaseCoordinator {
  public convenience init(navigation: UINavigationController) {
    let coordinatorManager = CoordinatorManager()
    self.init(router: RouterImp(rootController: navigation), coordinatorManager: coordinatorManager)
    coordinatorManager.rootCoordinator = self
  }

  public override func start() {
    transition(to: Scene(name: .Main, object: nil))
  }
}

public func configure() {

}

