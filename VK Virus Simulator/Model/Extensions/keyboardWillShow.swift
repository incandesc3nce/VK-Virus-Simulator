//
//  keyboardWillShow.swift
//  VK Virus Simulator
//
//  Created by Dmitry on 24.03.2024.
//

import Foundation
import UIKit

extension StartViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if infectPeriodTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
