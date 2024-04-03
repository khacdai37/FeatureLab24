//
//  HeartAnimationViewController.swift
//  MetaViewDemo
//
//  Created by teneocto on 22/03/2024.
//

import Foundation
import UIKit
import ELCore
import ELUIKit

protocol HeartAnimationView: BaseView {
}

class HeartAnimationViewController: ViewController, BindableType {
  var viewModel: HeartAnimationViewModelType!

  let targetPoint = CGPoint(x: 50, y: 50)

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  deinit {
    print("denit - HeartAnimationViewController")
  }

  private func setupView() {
    view.backgroundColor = .white
    let animationController = HeartAnimationController(CGPoint(x: 50, y: 50), globalSourcePoint: CGPoint(x: 350, y: 800))
    animationController.sourceView = view
  }

  func bindViewModel() {
  }
}
