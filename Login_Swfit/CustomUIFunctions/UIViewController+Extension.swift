//
//  UIViewController+Extension.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 15/11/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    
    func enableKeyboardHandling(for scrollView: UIScrollView) {
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: .main
            ) { notification in
                let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                scrollView.contentInset.bottom = keyboardFrame.height
                var verticalInsets = scrollView.verticalScrollIndicatorInsets
                verticalInsets.bottom = keyboardFrame.height
                scrollView.verticalScrollIndicatorInsets = verticalInsets
            }

            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: .main
            ) { _ in
                scrollView.contentInset = .zero
                scrollView.verticalScrollIndicatorInsets = .zero
            }
        }
    
    func pushWithFade(_ vc: UIViewController) {
        guard let nav = navigationController else { return }

        let fade = CATransition()
        fade.duration = 0.3
        fade.type = .fade
        fade.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        nav.view.layer.add(fade, forKey: nil)
        nav.pushViewController(vc, animated: false)
    }
    
    func pushRipple(_ vc: UIViewController) {
        guard let nav = navigationController else { return }

        let t = CATransition()
        t.duration = 0.45
        t.type = CATransitionType(rawValue: "rippleEffect")
        t.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        nav.view.layer.add(t, forKey: nil)
        nav.pushViewController(vc, animated: false)
    }
    

    
    func pushSlideFromRight(_ vc: UIViewController) {
        guard let nav = navigationController else { return }

        let t = CATransition()
        t.duration = 0.35
        t.type = .reveal
        t.subtype = .fromRight
        t.timingFunction = CAMediaTimingFunction(name: .easeIn)

        nav.view.layer.add(t, forKey: nil)
        nav.pushViewController(vc, animated: false)
    }



}
