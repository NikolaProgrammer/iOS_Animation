//
//  PlanetView.swift
//  Animation
//
//  Created by Nikolay Sereda on 13.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class PlanetView: UIView {


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        // center orbit
        let centerOrbit = UIBezierPath(arcCenter: center, radius: rect.width / 3, startAngle: 0, endAngle: CGFloat.pi * 2 , clockwise: true)
        addOrbit(in: self, withPath: centerOrbit.cgPath, color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1).cgColor)
        
        //first planet view
        let firstOrbitView = UIView()
        firstOrbitView.frame = CGRect(x: 0, y: 0, width: rect.width / 4, height: rect.width / 4)
        firstOrbitView.backgroundColor = .clear
        
        // first planet and orbit layer
        addPlanet(in: firstOrbitView, radius: 10, color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1).cgColor)
        
        let firstOrbit = UIBezierPath(arcCenter: firstOrbitView.center, radius: firstOrbitView.frame.width / 2, startAngle: 0, endAngle: CGFloat.pi * 2 , clockwise: false)
        addOrbit(in: firstOrbitView, withPath: firstOrbit.cgPath, color: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1).cgColor)
        
        addSubview(firstOrbitView)
        addAnimation(for: firstOrbitView, duration: 10, path: centerOrbit.cgPath)
        
        //second planet view
        let secondOrbitView = UIView()
        secondOrbitView.frame = CGRect(x: 0, y: 0, width: firstOrbitView.frame.width / 4, height: firstOrbitView.frame.width / 4)
        secondOrbitView.backgroundColor = .clear
        
        // second planet and orbit layer
        addPlanet(in: secondOrbitView, radius: 5, color: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1).cgColor)
        let secondOrbit = UIBezierPath(arcCenter: secondOrbitView.center, radius: secondOrbitView.frame.width / 1.5, startAngle: 0, endAngle: CGFloat.pi * 2 , clockwise: true)
        addOrbit(in: secondOrbitView, withPath: secondOrbit.cgPath, color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1).cgColor)
        
        firstOrbitView.addSubview(secondOrbitView)
        addAnimation(for: secondOrbitView, duration: 5, path: firstOrbit.cgPath)
        
        //third planet view
        let thirdOrbitView = UIView()
        thirdOrbitView.frame = CGRect(x: 0, y: 0, width: secondOrbitView.frame.width / 4, height: secondOrbitView.frame.width / 4)
        thirdOrbitView.backgroundColor = .clear
        
        // third planet
        addPlanet(in: thirdOrbitView, radius: 4, color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1).cgColor)
        
        secondOrbitView.addSubview(thirdOrbitView)
        addAnimation(for: thirdOrbitView, duration: 2, path: secondOrbit.cgPath)
        
    }
    
    //MARK: Private Methods
    private func addAnimation(for view: UIView, duration: CFTimeInterval, path: CGPath) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = duration
        animation.repeatCount = Float.infinity
        animation.path = path
        
        view.layer.add(animation, forKey: nil)
    }
    
    private func addPlanet(in view: UIView, radius: CGFloat, color: CGColor) {
        let layer = CAShapeLayer()
        let planet = UIBezierPath(arcCenter: view.center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2 , clockwise: true)
        layer.fillColor = color
        layer.path = planet.cgPath
        view.layer.addSublayer(layer)
    }
    
    private func addOrbit(in view: UIView, withPath path: CGPath, color: CGColor) {
        let layer = CAShapeLayer()
        layer.path = path
        layer.strokeColor = color
        layer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(layer)
    }

}
