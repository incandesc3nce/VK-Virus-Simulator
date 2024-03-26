//
//  StartSimulation.swift
//  VK Virus Simulator
//
//  Created by Dmitry on 24.03.2024.
//

import Foundation
import UIKit

func showError(_ message: String) -> UIAlertController {
    let alertError = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
    alertError.addAction(UIAlertAction(title: "OK", style: .default))
    
    return alertError
}


extension StartViewController {
    @objc func startSimulation() {
        if let peopleText = peopleCountTextField.text, let group = Int(peopleText), group > 0 {
            groupSize = group
        } else {
            present(showError("Вы ввели неверные данные о группе людей. Группа людей должна быть положительным числом."), animated: true)
            return
        }
        
        if let infectionText = infectCountTextField.text, let infectionRate = Int(infectionText), infectionRate > 0, infectionRate < 9 {
            infectionFactor = infectionRate
        } else {
            present(showError("Вы ввели неверные данные о заражения при контакте. Зараженные должны уметь переносить инфекцию хотя бы на одного человека при контакте и может максимум заразить 8 людей вокруг себя."), animated: true)
            return
        }
        
        if let periodText = infectPeriodTextField.text, let period = Double(periodText), period > 0 {
            T = period
        } else {
            present(showError("Вы ввели неверные данные о периоде инкубации. Период заражения должен быть положительным числом и через точку."), animated: true)
            return
        }
        
        let simVC = SimViewController()
        simVC.modalPresentationStyle = .fullScreen
        self.present(simVC, animated: true)
        
        print("Group: \(groupSize), Factor: \(infectionFactor), T: \(T)")
    }
}

