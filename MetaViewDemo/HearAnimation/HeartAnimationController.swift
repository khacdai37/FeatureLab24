//
//  HeartAnimationController.swift
//  MetaViewDemo
//
//  Created by teneocto on 25/03/2024.
//

import UIKit

class HeartAnimationController {
  private var localSourcePoint: CGPoint = .zero
  private var globalSourcePoint: CGPoint = .zero

  init(_ localSourcePoint: CGPoint, globalSourcePoint: CGPoint) {
    self.localSourcePoint = localSourcePoint
    self.globalSourcePoint = globalSourcePoint
  }

  deinit {
    print("denit - Heart Controller")
  }

  weak var sourceView: UIView? {
    didSet {
      guard let view = sourceView else {
        return
      }
      view.layer.setValue(self, forKey: "heartAnimationController")
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapgestureAction))
      view.addGestureRecognizer(tapGesture)
    }
  }

  @objc private func tapgestureAction(_ sender: UITapGestureRecognizer) {
    let point = sender.location(in: sourceView)
    let path = createCurvePath(endPoint: point, startPoint: localSourcePoint, controlPointOffset: localSourcePoint)
    addAnimation(with: path, point: point)

    receiveGlobalHeart()
  }

  private func addAnimation(with path: UIBezierPath, point: CGPoint) {
    let fadeAnim = CABasicAnimation(keyPath: "opacity")
    fadeAnim.fromValue = 1
    fadeAnim.toValue = 0
    fadeAnim.duration = 1.5
    let moveAlongPath = CAKeyframeAnimation(keyPath: "position")
    moveAlongPath.path = path.cgPath
    moveAlongPath.speed = -2
    moveAlongPath.calculationMode = CAAnimationCalculationMode.paced
    moveAlongPath.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
    moveAlongPath.duration = 3
    moveAlongPath.beginTime = 0.3

    let layer = createHearLayerImageContent(UIImage(named: "heart"))
    layer.frame = CGRect(origin: point, size: CGSize(width: 30, height: 30))

    let scale = CABasicAnimation(keyPath: "transform.scale")
    scale.fromValue = 4
    scale.toValue = 1
    scale.duration = 0.3

    let groupAnimation = CAAnimationGroup()
    groupAnimation.duration = 3
    groupAnimation.animations = [fadeAnim, moveAlongPath, scale]

    sourceView?.layer.addSublayer(layer)
    groupAnimation.delegate = AnimationDelegate(layer: layer)
    layer.add(groupAnimation, forKey: "localHeartAnimation")
  }

  private func createCurvePath(endPoint: CGPoint, startPoint: CGPoint, controlPointOffset: CGPoint) -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: startPoint)
    let x = startPoint.x + (endPoint.x - startPoint.x)/2 + (startPoint.x < endPoint.x ? -1 : 1) * controlPointOffset.x
    let y = startPoint.y + (endPoint.y - startPoint.y)/2
    path.addQuadCurve(to: endPoint, controlPoint: CGPoint(x: x, y: y) )
    return path
  }

  private func createHearLayerImageContent(_ image: UIImage?) -> CALayer {
    let layer = CALayer()
    layer.opacity = 0
    layer.contents = image?.cgImage
    return layer
  }

  private class AnimationDelegate: NSObject, CAAnimationDelegate {
    weak var layerToRemove: CALayer?

    init(layer: CALayer) {
      self.layerToRemove = layer
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
      if flag, let layer = layerToRemove {
        layer.removeAllAnimations()
        layer.removeFromSuperlayer()
      }
    }
  }

  let heartStyles: [UIColor] = [.red, .yellow, .blue]
  var currentHeartStyles: [UIColor] = []
}

extension HeartAnimationController {
  func receiveGlobalHeart() {
    if currentHeartStyles.isEmpty {
      currentHeartStyles = heartStyles
    }
    let heartImage = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate).mask(with: currentHeartStyles.removeFirst())
    let layer = createHearLayerImageContent(heartImage)
    layer.frame = CGRect(origin: globalSourcePoint, size: CGSize(width: 30, height: 30))
    sourceView?.layer.addSublayer(layer)
    let offset = [-50, -30, 0, 30, 50].shuffled().first ?? 0
    let path = createCurvePath(endPoint: CGPoint(x: globalSourcePoint.x, y: globalSourcePoint.y - 300), startPoint: globalSourcePoint, controlPointOffset: CGPoint(x: offset, y: 0))
    let fadeAnim = CABasicAnimation(keyPath: "opacity")
    fadeAnim.fromValue = 1
    fadeAnim.toValue = 0
    fadeAnim.duration = 1.5

    let moveAlongPath = CAKeyframeAnimation(keyPath: "position")
    moveAlongPath.path = path.cgPath
    moveAlongPath.speed = 2
    moveAlongPath.calculationMode = CAAnimationCalculationMode.paced
    moveAlongPath.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
    moveAlongPath.duration = 4

    let animation = CABasicAnimation(keyPath: "transform.rotation.z")
    animation.duration = 1
    animation.repeatCount = HUGE
    animation.speed = 3
    animation.autoreverses = true
    animation.fromValue = -0.1
    animation.toValue = 0.1

    let groupAnimation = CAAnimationGroup()
    groupAnimation.duration = 5
    groupAnimation.animations = [fadeAnim, moveAlongPath, animation]
    groupAnimation.delegate = AnimationDelegate(layer: layer)

    layer.add(groupAnimation, forKey: "globalHeartAnimation")

  }
}

extension HeartAnimationController {
  func testPath(_ path: UIBezierPath) -> UIBezierPath {
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.strokeColor = UIColor.blue.cgColor
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.lineWidth = 1.0
    sourceView?.layer.addSublayer(shapeLayer)
    return path
  }
}

extension UIImage {

    public func mask(with color: UIColor) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        let rect = CGRect(origin: CGPoint.zero, size: size)

        color.setFill()
        self.draw(in: rect)

        context.setBlendMode(.sourceIn)
        context.fill(rect)

        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }

}
