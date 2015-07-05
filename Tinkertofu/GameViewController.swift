//
//  GameViewController.swift
//  Tinkertofu
//
//  Created by Yin Jie Soon on 5/7/15.
//  Copyright (c) 2015 Tinkercademy. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var tofu : TofuScene!
    
    func moveTofu() {
        // Add all your movement here
        
        tofu.moveForward()
        tofu.moveForward()
        tofu.moveForward()
        tofu.turnRight()
        
    }
    
    // -------- setup code ----------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tofu = TofuScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.presentScene(tofu)
        moveTofu()
        tofu.move()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}