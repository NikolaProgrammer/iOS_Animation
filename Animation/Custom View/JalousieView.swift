//
//  JalousieView.swift
//  Animation
//
//  Created by Nikolay Sereda on 16.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class JalousieView: UIView {
    
    //MARK: Properties
    var aquaImageLayers: [CALayer] = []
    var cosmicImageLayers: [CALayer] = []
    let layerToDivide = 5
    var isPrimaryImage = true
    
    //MARK: View lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    //MARK: Methods
    @objc func changeImageButtonTapped() {

        for index in (0..<layerToDivide).reversed() {
            let layerToReplace = isPrimaryImage ? aquaImageLayers[index] : cosmicImageLayers[index]
            let replaceLayer = isPrimaryImage ? cosmicImageLayers[index] : aquaImageLayers[index]
            moveSublayerToFront(layer: replaceLayer)
            let animation = CABasicAnimation(keyPath: "position.y")
            animation.duration = 3
            animation.fromValue = -frame.height / 5
            animation.toValue = layerToReplace.frame.origin.y + bounds.height / 10
            
            replaceLayer.add(animation, forKey: nil)
        }
        isPrimaryImage = !isPrimaryImage
    }
    
    
    @objc func flipImageButtonTapped() {
        for index in 0..<layerToDivide {
            let layerToReplace = aquaImageLayers[index]
            let replaceLayer = cosmicImageLayers[index]
         
            let flip = CABasicAnimation(keyPath: "transform.rotation.x")
            flip.fromValue = 0
            flip.toValue = -CGFloat.pi/2
            flip.duration = 1
            
            let flipBack = CABasicAnimation(keyPath: "transform.rotation.x")
            flipBack.fromValue = -CGFloat.pi/2
            flipBack.toValue = 0
            flipBack.duration = 1
            flipBack.beginTime = 1
            
            let change = CABasicAnimation(keyPath: "contents")
            change.fromValue = layerToReplace.contents
            change.toValue = replaceLayer.contents

            let anim = CAAnimationGroup()
            anim.animations = [flip,flipBack, change]
            anim.duration = 3
            anim.fillMode = kCAFillModeForwards
            anim.isRemovedOnCompletion = false

            layerToReplace.add(anim, forKey: nil)
            
        }

    }
    
    //MARK: Private Methods
    private func moveSublayerToFront(layer: CALayer) {
        layer.removeFromSuperlayer()
        self.layer.addSublayer(layer)
    }
    private func configureView() {
        let aqua = UIImage(named: "aqua")
        aquaImageLayers = divideOnLayers(image: aqua!)
        
        let cosmic = UIImage(named: "cosmic")
        cosmicImageLayers = divideOnLayers(image: cosmic!)
        
        for layer in aquaImageLayers {
            self.layer.addSublayer(layer)
        }
    }
    
    private func divideOnLayers(image: UIImage) -> [CALayer] {
        var layers: [CALayer] = []
        
        for index in 0..<layerToDivide {
            let imageLayer = CALayer()
            imageLayer.contents = image.cgImage
            
            let visibleOffset = CGFloat(Double(index) * 0.2)
            imageLayer.frame = CGRect(x: 0, y: (frame.height / 5) * CGFloat(index), width: bounds.width, height: frame.height / 5)
            imageLayer.contentsRect = CGRect(x: 0, y: visibleOffset, width: 1, height: 0.2)
            
            layers.append(imageLayer)
        }
        
        return layers
    }
}













