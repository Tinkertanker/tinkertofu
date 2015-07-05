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
    
    var turtle : TurtleScene!
    
    func moveTurtle() {
        // Add all your movement here
        
        turtle.moveForward()
        turtle.moveForward()
        turtle.moveForward()
        turtle.turnRight()
        turtle.moveForward()
        
    }
    
    // -------- setup code ----------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        turtle = TurtleScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.presentScene(turtle)
        moveTurtle()
        turtle.move()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}