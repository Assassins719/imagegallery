//
//  GradientView.swift
//  ImageViewer
//
//  Created by Admin on 6/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//
import GradientView
import Foundation

extension UIView {
    func drawTopGradient(){
        self.layer.mask = CAGradientLayer.topGradient(withBound: self.bounds)
        self.backgroundColor = UIColor.black
    }
    func drawBottomGradient(){
        self.layer.mask = CAGradientLayer.bottomGradient(withBound: self.bounds)
        self.backgroundColor = UIColor.black
    }
}
