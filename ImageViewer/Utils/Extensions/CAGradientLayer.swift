//
//  CAGradientLayer.swift
//  ImageViewer
//
//  Created by Admin on 6/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

extension CAGradientLayer {
    
    static func topGradient(withBound bound:CGRect)->CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        let whiteColor = UIColor.blue
        gradient.colors = [whiteColor.withAlphaComponent(1.0).cgColor, whiteColor.withAlphaComponent(1.0), whiteColor.withAlphaComponent(0.0).cgColor]
        gradient.locations = [NSNumber(value: 0.0), NSNumber(value: 0.8),NSNumber(value: 1.0)]
        gradient.frame = bound
        return gradient
    }
    
    static func bottomGradient(withBound bound:CGRect)->CAGradientLayer {
        let whiteColor = UIColor.blue
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y:1.0)
        gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor, whiteColor.withAlphaComponent(1.0), whiteColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [NSNumber(value: 0.0), NSNumber(value: 0.2),NSNumber(value: 1.0)]
        gradient.frame = bound
        
        return gradient
    }
}

