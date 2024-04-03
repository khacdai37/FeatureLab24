//
//  TaptickFeedback.swift
//  MetaViewDemo
//
//  Created by Nguyen Khac Dai on 03/04/2024.
//

import UIKit
import ELCore
import ELUIKit

protocol TaptickFeedbackView: BaseView {
}

class TaptickFeedbackViewController: ViewController, BindableType {
  var viewModel: TaptickFeedbackViewModelType!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  private func setupView() {
    view.backgroundColor = .white
    let clickMeButton = UIButton(type: .custom)
    clickMeButton.setTitle("Click Me!", for: .normal)
    clickMeButton.setTitleColor(.red, for: .normal)
    view.addSubview(clickMeButton)
    clickMeButton.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    clickMeButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
  }

  func bindViewModel() {
  }

  var i = 0
  @objc func tapped() {
    i += 1
    print("Running \(i)")

    switch i {
    case 1:
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.error)

    case 2:
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.success)

    case 3:
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.warning)

    case 4:
      let generator = UIImpactFeedbackGenerator(style: .light)
      generator.impactOccurred()

    case 5:
      let generator = UIImpactFeedbackGenerator(style: .medium)
      generator.impactOccurred()

    case 6:
      let generator = UIImpactFeedbackGenerator(style: .heavy)
      generator.impactOccurred()

    default:
      let generator = UISelectionFeedbackGenerator()
      generator.selectionChanged()
      i = 0
    }
  }
}

protocol TaptickFeedbackViewModelType: BaseViewModelType {
}

class TaptickFeedbackViewModel: TaptickFeedbackViewModelType {
  weak var coordinator: Coordinator?
}

