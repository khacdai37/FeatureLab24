//
//  RTCEngineKitViewController.swift
//  MetaViewDemo
//
//  Created by teneocto on 06/03/2024.
//

import AgoraRtcKit
import FURenderKit
import SnapKit
import UIKit
import ELCore
import ELUIKit

protocol RTCEngineKitView: BaseView {

}

class RTCEngineKitViewController: ViewController, RTCEngineKitView, BindableType {
  lazy var rtcEngineKit: AgoraRtcEngineKit = {
    let rtcEngineKit = AgoraRtcEngineKit.sharedEngine(withAppId: viewModel.appKey, delegate: self)
    return rtcEngineKit
  }()

  lazy var localView = {
    let view = UIView()
    self.view.addSubview(view)
    view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    return view
  }()

  lazy var videoCanvas = AgoraRtcVideoCanvas()

  var viewModel: RTCEngineKitViewModelType!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()

    let addSticker = UIBarButtonItem(title: "sticker", style: .plain, target: self, action: #selector(addSticker))
    navigationItem.rightBarButtonItems = [addSticker]
  }

  func bindViewModel() {

  }

  @objc
  private func addSticker() {
    guard let path = Bundle.main.path(forResource: "CatSparks", ofType: "bundle") else {
      return
    }
    FURenderer.item(withContentsOfFile: path)
  }

  private func setupView() {
    setupFaceUnity()
    rtcEngineKit.setVideoFrameDelegate(FUManager.shared())
    rtcEngineKit.setClientRole(.broadcaster)

    let capture = AgoraCameraCapturerConfiguration()
    capture.cameraDirection = .front
    capture.frameRate = 30
    rtcEngineKit.setCameraCapturerConfiguration(capture)

    let videoEncoderConfig = AgoraVideoEncoderConfiguration()
    videoEncoderConfig.dimensions = CGSize(width: 1280, height: 720)
    videoEncoderConfig.frameRate = .fps30
    rtcEngineKit.setVideoEncoderConfiguration(videoEncoderConfig)

    videoCanvas.uid = 0
    videoCanvas.view = localView
    videoCanvas.renderMode = .hidden
    rtcEngineKit.setupLocalVideo(videoCanvas)

    rtcEngineKit.joinChannel(byToken: nil, channelId: viewModel.channel, info: nil, uid: 0, joinSuccess: nil)
    rtcEngineKit.enableVideo()
    rtcEngineKit.enableAudio()
    rtcEngineKit.startPreview()
  }
}

extension RTCEngineKitViewController: AgoraRtcEngineDelegate {}

import CoreVideo

extension RTCEngineKitViewController {
  private func setupFaceUnity() {
    DispatchQueue.global().async {
      FUManager.setupFUSDK()
    }
  }
}

