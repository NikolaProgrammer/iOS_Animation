//
//  JalousieViewController.swift
//  Animation
//
//  Created by Nikolay Sereda on 16.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class JalousieViewController: UIViewController {
    
    @IBOutlet weak var contentView: JalousieView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change image", style: .plain, target: contentView, action: #selector(JalousieView.squareChangeButtonTapped))
    }

}
