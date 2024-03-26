//
//  updatePeopleLabels.swift
//  VK Virus Simulator
//
//  Created by Dmitry on 25.03.2024.
//

import Foundation
import UIKit

extension SimViewController {
    func updateLabels() {
        let infectedCount = infection.infectedCount
        let healthyCount = infection.healthyCount
        
        
        healthyLabel.text = "Здоровых: \(healthyCount)"
        infectedLabel.text = "Зараженных: \(infectedCount)"
    }
}
