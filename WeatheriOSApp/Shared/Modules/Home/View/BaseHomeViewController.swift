//
//  BaseBaseHomeViewControllerViewController
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation
import UIKit
import Combine

// MARK: HomeViewController
class BaseHomeViewController: UIViewController {
    
    /// Disposable bag
    var disposeBag: DisposeBag = DisposeBag()
            
    /// Analytics manager.
    let analyticsManager: AnalyticsManager

    /// Theme.
    let theme: Theme
    
    // MARK: - Init Functions

    /// Initializes the shop search view.
    init(analyticsManager: AnalyticsManager,
         theme: Theme) {
        self.analyticsManager = analyticsManager
        self.theme = theme

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
