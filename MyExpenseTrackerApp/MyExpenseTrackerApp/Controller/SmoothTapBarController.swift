//
//  SmoothTapBarController.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 14.05.2023.
//

import Foundation
import UIKit

class SmoothTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let fromView = selectedViewController?.view, let toView = viewController.view {
            if fromView != toView {
                animateTabTransition(fromView: fromView, toView: toView)
            }
        }
        return true
    }
    
    func animateTabTransition(fromView: UIView, toView: UIView) {
        let duration = 0.3
        UIView.transition(from: fromView, to: toView, duration: duration, options: [.transitionCrossDissolve], completion: nil)
    }
}


