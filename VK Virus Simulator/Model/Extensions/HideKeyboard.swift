//
//  HideKeyboard.swift
//  VK Virus Simulator
//
//  Created by Dmitry on 24.03.2024.
//

import Foundation
import UIKit

extension StartViewController {
    func setupToolbar(){
        let bar = UIToolbar()
        
        let doneButton = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        bar.items = [flexSpace, flexSpace, doneButton]
        bar.sizeToFit()
        
        peopleCountTextField.inputAccessoryView = bar
        infectCountTextField.inputAccessoryView = bar
        infectPeriodTextField.inputAccessoryView = bar
    }
    
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
}

