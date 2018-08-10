//
//  tickerView.swift
//  Animation
//
//  Created by Nikolay Sereda on 13.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class TickerView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 0, y: 200, width: 200, height: 100)
        textLayer.foregroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1).cgColor
        textLayer.string = "Hello"
    
        let transition = CABasicAnimation(keyPath: "position.x")
        transition.fromValue = 0
        transition.toValue = rect.width + 200
        transition.repeatCount = Float.infinity
        transition.duration = 5
        
        textLayer.add(transition, forKey: nil)
        
        layer.addSublayer(textLayer)
    }

}
