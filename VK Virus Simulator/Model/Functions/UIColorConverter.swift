//
//  UIColorConverter.swift
//  VK Virus Simulator
//
//  Created by Dmitry on 24.03.2024.
//

import Foundation
import UIKit

func convertColorFromRGB(r red: CGFloat, g green: CGFloat, b blue: CGFloat, alpha: CGFloat) -> UIColor{
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}
