//
//  CarRacingView.swift
//  Animation
//
//  Created by Nikolay Sereda on 16.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class CarRacingView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        //road path
        let height = frame.height
        let width = frame.width
        
        let roadPath = UIBezierPath()
        roadPath.move(to: CGPoint(x: 50, y: height * 0.2))
        roadPath.addQuadCurve(to: CGPoint(x: width - 50, y: height * 0.2), controlPoint: CGPoint(x: width / 2, y: height * 0.05))
        roadPath.addQuadCurve(to: CGPoint(x: width - 50, y: height * 0.25), controlPoint: CGPoint(x: width - 10, y: height * 0.225))
        roadPath.addLine(to: CGPoint(x: width - 100, y: height * 0.35))
        roadPath.addQuadCurve(to: CGPoint(x: width - 100, y: height * 0.5), controlPoint: CGPoint(x: width - 125, y: height * 0.425))
        roadPath.addQuadCurve(to: CGPoint(x: width / 2 - 100, y: height * 0.6), controlPoint: CGPoint(x: width / 2, y: height * 0.8))
        roadPath.addQuadCurve(to: CGPoint(x: 50, y: height * 0.2), controlPoint: CGPoint(x: 0, y: height * 0.4))
        
        // asphalt layer
        let roadLayer = CAShapeLayer()
        roadLayer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        roadLayer.fillColor = UIColor.clear.cgColor
        roadLayer.lineWidth = 12
      
        roadLayer.path = roadPath.cgPath
        layer.addSublayer(roadLayer)
        
        // marking layer
        let markingLayer = CAShapeLayer()
        markingLayer.lineDashPattern = [20]
        markingLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        markingLayer.fillColor = UIColor.clear.cgColor
        markingLayer.lineWidth = 3
        
        markingLayer.path = roadPath.cgPath
        layer.addSublayer(markingLayer)
        
        // car
        let carLayer = CALayer()
        carLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        carLayer.contents = UIImage(named: "car")?.cgImage
        
        // car moving animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 5
        animation.repeatCount = Float.infinity
        animation.path = roadPath.cgPath
        animation.rotationMode = kCAAnimationRotateAuto
        
        carLayer.add(animation, forKey: nil)
        
        layer.addSublayer(carLayer)
    }

}
