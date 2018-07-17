//
//  CubeViewController.swift
//  Animation
//
//  Created by Nikolay Sereda on 17.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class CubeViewController: UIViewController {
    
    var containerLayer: CATransformLayer!
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create transform layer
        containerLayer = CATransformLayer()
        containerLayer.frame = view.bounds
        
        view.layer.addSublayer(containerLayer)
        
        
        //create cube faces
        let frontFace = CALayer()
        frontFace.frame = CGRect(x: view.center.x - 75, y: view.center.y - 75, width: 150, height: 150)
        frontFace.backgroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 0.5973745493)
        frontFace.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 75)
        containerLayer.addSublayer(frontFace)
        
        let backFace = CALayer()
        backFace.frame = CGRect(x: view.center.x - 75, y: view.center.y - 75, width: 150, height: 150)
        backFace.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.6017127404)
        backFace.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -75)
        containerLayer.addSublayer(backFace)
        
        let upFace = CALayer()
        upFace.frame = CGRect(x: view.center.x - 75, y: view.center.y - 75, width: 150, height: 150)
        upFace.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 0.599214994)
        let upFaceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -75, 0)
        upFace.transform = CATransform3DRotate(upFaceTransform, -(.pi / 2), 1, 0, 0)
        containerLayer.addSublayer(upFace)
        
        let downFace = CALayer()
        downFace.frame = CGRect(x: view.center.x - 75, y: view.center.y - 75, width: 150, height: 150)
        downFace.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0.6013934796)
        let downFaceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 75, 0)
        downFace.transform = CATransform3DRotate(downFaceTransform, -(.pi / 2), 1, 0, 0)
        containerLayer.addSublayer(downFace)

    }
    
    //MARK: Actions
    @IBAction func rotateCube(_ sender: UIPanGestureRecognizer) {
        let xOffset = sender.translation(in: view).x
        let yOffset = sender.translation(in: view).y
        
        var transform: CATransform3D = CATransform3DIdentity
        transform.m34 = -1.0 / 1000
        
        if sender.state == .changed {
            transform = CATransform3DRotate(transform, xOffset, 0, -1, 0)
            transform = CATransform3DRotate(transform, yOffset, -1, 0, 0)
            containerLayer.transform = transform
            
            sender.setTranslation(CGPoint.zero, in: view)
        }
       
    }
}










