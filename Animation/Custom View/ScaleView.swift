//
//  ScaleView.swift
//  Animation
//
//  Created by Nikolay Sereda on 13.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class ScaleView: UIView {
    
    private let moveAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.autoreverses = false
        animation.duration = 0.5
        return animation
    }()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let objectLayer = CALayer()
        objectLayer.frame = CGRect(
            x: rect.width / 2 - 10,
            y: rect.height / 2 - 100,
            width: 20,
            height: 20)
        
        objectLayer.backgroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1).cgColor
        layer.addSublayer(objectLayer)
        
        let trashImageLayer = CALayer()
        trashImageLayer.frame = CGRect(
            x: rect.width / 2 - 50,
            y: rect.height / 2,
            width: 100,
            height: 200)
        trashImageLayer.contents = UIImage(named: "trash")?.cgImage
        layer.addSublayer(trashImageLayer)
    
    }

    @IBAction func moveToTrashButtonTapped(_ sender: UIButton) {
        let objectLayer = layer.sublayers![1]
        moveAnimation.fromValue = frame.height / 2 - 100
        moveAnimation.toValue = frame.height / 2 + 110
        
        objectLayer.add(moveAnimation, forKey: nil)
    }
    
    @IBAction func scaleButtonTapped(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        }) { (true) in
            UIButton.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
            })
        }
    }
    
    
    
}
