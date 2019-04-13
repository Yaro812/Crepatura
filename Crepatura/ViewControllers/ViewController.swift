//
//  ViewController.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 14/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeKeyboard(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        observeKeyboard(false)
    }

    @discardableResult
    func addDismissKeyboardGesture(to view: UIView? = nil) -> UITapGestureRecognizer {
        let view: UIView = view ?? self.view
        let gesture = UITapGestureRecognizer()
        gesture.cancelsTouchesInView = false
        gesture.addTarget(self, action: #selector(tapView))
        view.addGestureRecognizer(gesture)
        return gesture
    }

    /// use this method to handle keyboard disappearing
    func keyboardWillHide(startFrame: CGRect,
                          endFrame: CGRect,
                          duration: TimeInterval,
                          curve: UIView.AnimationOptions) {
        // override
    }

    // use this method to handle keyboard appearing and changing frame
    func keyboardWillChange(startFrame: CGRect,
                            endFrame: CGRect,
                            duration: TimeInterval,
                            curve: UIView.AnimationOptions) {
        // override
    }

    @objc
    private func tapView(sender: UITapGestureRecognizer) {
        sender.view?.window?.endEditing(true)
    }

    private func observeKeyboard(_ observe: Bool) {
        let notificationCenter = NotificationCenter.default
        if observe {
            notificationCenter.addObserver(self,
                                           selector: #selector(adjustForKeyboard),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
            notificationCenter.addObserver(self,
                                           selector: #selector(adjustForKeyboard),
                                           name: UIResponder.keyboardWillChangeFrameNotification,
                                           object: nil)
        } else {
            notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            notificationCenter.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        }
    }

    @objc
    private func adjustForKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        let startFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let rawCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).uintValue
        let curve = UIView.AnimationOptions(rawValue: rawCurve << 16)

        if notification.name == UIResponder.keyboardWillHideNotification {
            keyboardWillHide(startFrame: startFrame, endFrame: endFrame, duration: duration, curve: curve)
        } else {
            keyboardWillChange(startFrame: startFrame, endFrame: endFrame, duration: duration, curve: curve)
        }
    }
}
