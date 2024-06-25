//
//  SplashViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftMessages
fileprivate let hideInterval: TimeInterval = 0.6
func showToast(message: String?) {
    if let validMessage = message {
        let toastView: SDToastView = try! SwiftMessages.viewFromNib()
        toastView.configureContent(body: validMessage)
        toastView.backgroundView.backgroundColor = UIColor.lightGray
        toastView.backgroundView.layer.cornerRadius = 15
        toastView.backgroundView.layer.masksToBounds = true

        var customViewConfig = SwiftMessages.defaultConfig
        customViewConfig.presentationStyle = .bottom
        customViewConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        customViewConfig.duration = .seconds(seconds: hideInterval)
        customViewConfig.dimMode = .none
        customViewConfig.shouldAutorotate = true
        customViewConfig.interactiveHide = false
        customViewConfig.preferredStatusBarStyle = .default
        SwiftMessages.show(config: customViewConfig, view: toastView)
    }
}
