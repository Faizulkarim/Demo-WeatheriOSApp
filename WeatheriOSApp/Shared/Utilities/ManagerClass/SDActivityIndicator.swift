//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit
import NVActivityIndicatorView

fileprivate var thisView: UIView?

extension UIViewController {
    
    func addLoadIndicator() {
        removeLoadIndicator()
        thisView = UIView(frame: UIScreen.main.bounds)
        let otActivityIndicatorFrame = CGRect(x: thisView!.frame.width/2 - 25, y: thisView!.frame.height/2 - 25, width: 50, height: 50)
        let otActivityIndicator = NVActivityIndicatorView(frame: otActivityIndicatorFrame, type: .ballRotateChase, color: UIColor.black, padding: 10)
        otActivityIndicator.startAnimating()
        thisView!.addSubview(otActivityIndicator)
        thisView?.backgroundColor = UIColor.init(named: "appBackground")?.withAlphaComponent(0.2)
        view.addSubview(thisView!)
    }
    
    func removeLoadIndicator() {
        thisView?.removeFromSuperview()
        thisView = nil
    }
    
}
