//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

extension UIView {
    //MARK: Gradient
    func addLinearGradient(startPoint: CGPoint, endPoint: CGPoint, startColor: UIColor, endColor: UIColor) {
          // Create gradient layer
          let gradientLayer = CAGradientLayer()
          gradientLayer.frame = bounds
          
          // Set colors for the gradient
          gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
          
          // Define the direction of the gradient
          gradientLayer.startPoint = startPoint
          gradientLayer.endPoint = endPoint
          
          // Add the gradient layer to the view's layer
          layer.insertSublayer(gradientLayer, at: 0)
      }
    
    //MARK: ADD Border
    func addBorder(color: UIColor? = UIColor.clear, width: CGFloat, radius: CGFloat) {
            layer.borderColor    = color!.cgColor
            layer.borderWidth    = width
            layer.cornerRadius   = radius
        }
  //MARK: ADD Shadow
    func addShadowWithCornerRedious(color: UIColor, opacity: Float, sizeX: CGFloat, sizeY: CGFloat, shadowRadius: CGFloat, cornerRadius: CGFloat) {
        layer.shadowColor   = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset  = CGSize(width: sizeX, height: sizeY)
        layer.shadowRadius  = shadowRadius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
    
  //MARK: Custom Tap Action
    fileprivate typealias ReturnGestureAction = (() -> Void)?
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer1"
    }
    fileprivate var tapGestureRecognizerAction: ReturnGestureAction? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? ReturnGestureAction
            return tapGestureRecognizerActionInstance
        }
    }
    
    func handleTapToAction(action: (() -> Void)?) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureHanldeAction))
        self.tapGestureRecognizerAction = action
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }

    @objc func tapGestureHanldeAction() {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {

        }
    }


}




