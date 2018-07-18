//
//  JalousieView.swift
//  Animation
//
//  Created by Nikolay Sereda on 16.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

fileprivate enum JalousieAnimationType {
    case vertical
    case horizontal
}

class JalousieView: UIView {
    
    //MARK: Properties
    let aquaImage = UIImage(named: "aqua")!
    let cosmicImage = UIImage(named: "cosmic")!
    var aquaImageLayers: [[CALayer]] = []
    var cosmicImageLayers: [[CALayer]] = []
    
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
        performSlideJalousieAnimation(animationType: .horizontal, layers: 5)
    }
    
    @objc func squareChangeButtonTapped() {
        let layersNumber = (horizontal: 5, vertical: 5)
        sliceImages(layersNumber: layersNumber)
        
        for horisontalIndex in 0..<layersNumber.horizontal {
            for verticalIndex in 0..<layersNumber.vertical {
                let layerToReplace = aquaImageLayers[horisontalIndex][verticalIndex]
                let replaceLayer = cosmicImageLayers[horisontalIndex][verticalIndex]
                
                moveSublayerToFront(layer: replaceLayer)
                
                let animation = CABasicAnimation(keyPath: "bounds.size.height")
                animation.duration = Double.random(min: 0.2, max: 1)
                animation.fromValue = CGFloat(0)
                animation.toValue = layerToReplace.bounds.size.height
    
                replaceLayer.add(animation, forKey: nil)
            }
        }
    }
    
    @objc func flipImageButtonTapped() {
        let layersNumber = (horizontal: 5, vertical: 1)
        
        sliceImages(layersNumber: layersNumber)
        
        for horisontalIndex in (0..<layersNumber.horizontal).reversed() {
            for verticalIndex in 0..<layersNumber.vertical {
                let layerToReplace = aquaImageLayers[horisontalIndex][verticalIndex]
                let replaceLayer = cosmicImageLayers[horisontalIndex][verticalIndex]

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

    }
    
    //MARK: Private Methods
    private func performSlideJalousieAnimation(animationType: JalousieAnimationType, layers: Int) {
        let layersNumber = animationType == .vertical ? (horizontal: layers, vertical: 1) : (horizontal: 1, vertical: layers)
        
        sliceImages(layersNumber: layersNumber)
        
        for horisontalIndex in (0..<layersNumber.horizontal).reversed() {
            for verticalIndex in 0..<layersNumber.vertical {
                let layerToReplace = aquaImageLayers[horisontalIndex][verticalIndex]
                let replaceLayer = cosmicImageLayers[horisontalIndex][verticalIndex]
                
                moveSublayerToFront(layer: replaceLayer)
                
                let animation = CABasicAnimation()
                animation.duration = 3
                switch animationType {
                case .vertical:
                    animation.keyPath = "position.y"
                    animation.fromValue = -frame.height / CGFloat(layersNumber.horizontal)
                    animation.toValue = layerToReplace.frame.origin.y + bounds.height / CGFloat(layersNumber.horizontal)
                case .horizontal:
                    animation.keyPath = "position.x"
                    animation.fromValue = -frame.width / CGFloat(layersNumber.vertical)
                    animation.toValue = layerToReplace.frame.origin.x + bounds.width / CGFloat(layersNumber.vertical) / 2
                }
                
                replaceLayer.add(animation, forKey: nil)
            }
        }
    }
    
    private func sliceImages(layersNumber: (horizontal: Int, vertical: Int)) {
        aquaImageLayers = divideOnLayers(forImage: aquaImage, layersNumber: layersNumber)
        cosmicImageLayers = divideOnLayers(forImage: cosmicImage, layersNumber: layersNumber)
        
        if layer.contents != nil {
            layer.contents = nil
        }
        
        layer.sublayers?.removeAll()
        
        for layers in aquaImageLayers {
            for layer in layers {
                self.layer.addSublayer(layer)
            }
        }
    }
    
    private func moveSublayerToFront(layer: CALayer) {
        layer.removeFromSuperlayer()
        self.layer.addSublayer(layer)
    }
    
    private func configureView() {
        layer.contents = aquaImage.cgImage
    }
    
    private func divideOnLayers(forImage image: UIImage, layersNumber: (horizontal: Int, vertical: Int)) -> [[CALayer]] {
        
        var layers: [[CALayer]] = []
        
        // define what part of the screen layer will occupy
        let horizontalSection: CGFloat = 1 / CGFloat(layersNumber.horizontal)
        let verticalSection: CGFloat = 1 / CGFloat(layersNumber.vertical)
        
        for horizontalIndex in 0..<layersNumber.horizontal {
            var verticalLayers: [CALayer] = []
            for verticalIndex in 0..<layersNumber.vertical {
                
                // define hotizontal and vertical origin offsets
                let horizontalOffset = horizontalSection * CGFloat(horizontalIndex)
                let verticalOffset = verticalSection * CGFloat(verticalIndex)
                
                // create layer with image
                let imageLayer = CALayer()
                imageLayer.contents = image.cgImage
            
                //calculate layers frame
                imageLayer.frame = CGRect(
                    x: (frame.width * verticalSection) * CGFloat(verticalIndex),
                    y: (frame.height * horizontalSection) * CGFloat(horizontalIndex),
                    width: frame.width * verticalSection,
                    height: frame.height * horizontalSection)
                
                //calculate layers contetsRect
                imageLayer.contentsRect = CGRect(x: verticalOffset, y: horizontalOffset, width: verticalSection, height: horizontalSection)
                
                verticalLayers.append(imageLayer)
            }
            layers.append(verticalLayers)
        }
        
        return layers
    }
}





























