//
//  ViewController.swift
//  MetaViewDemo
//
//  Created by teneocto on 01/03/2024.
//

import UIKit
import Combine
import ELCore
import ELUIKit

protocol MainView: BaseView {
}

class MainViewController: ViewController, BindableType, BaseView {
  lazy var tableView: UITableView = {
    UITableView(frame: .zero, style: .plain)
  }()
  var cancellable = Set<AnyCancellable>()
  var viewModel: MainViewModelType!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  private func setupView() {
    title = "Everyday Demo App"
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }

  func bindViewModel() {
    viewModel.onDataChanged.sink {[weak self] _ in
      guard let self else { return }
      tableView.reloadData()
    }
    .store(in: &cancellable)
  }
}

extension MainViewController: UITableViewDataSource {
  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    viewModel.features.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = viewModel.features[indexPath.row].rawValue
    return cell
  }
}

extension MainViewController: UITableViewDelegate {
  func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = viewModel.features[indexPath.row]
    switch item {
    case .rtcEngineKit:
      viewModel.coordinator?.transition(to: Scene(name: .RTCEngineKit, object: nil))
    }
  }
}

