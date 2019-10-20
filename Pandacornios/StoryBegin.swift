//
//  StoryBegin.swift
//  Pandacornios
//
//  Created by Nathalia Melare on 20/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit

class StoryBegin: SKScene {
    
    var buttonBack : SKSpriteNode = SKSpriteNode(imageNamed: "blueRetangleOff")
    var buttonFoward: SKSpriteNode = SKSpriteNode(imageNamed: "blueRetangleOn")
    var firstImage: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOn")
    var secondImage: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    
    override func sceneDidLoad() {
        self.buttonBackSetUp()
        self.buttonFowardSetUp()
        self.firstImageSetUp()
    }
    
    func buttonBackSetUp() {
        self.addChild(buttonBack)
        buttonBack.name = "buttonBack"
        buttonBack.position = CGPoint(x: size.width * 0.15,   y: size.height * 0.1)
        buttonBack.isUserInteractionEnabled = false
    }
    
    func buttonFowardSetUp() {
        self.addChild(buttonFoward)
        buttonFoward.name = "buttonFoward"
        buttonFoward.position = CGPoint(x: size.width * 0.85, y: size.height * 0.1)
        buttonFoward.isUserInteractionEnabled = false
    }
    
    func  firstImageSetUp() {
        self.addChild(firstImage)
        firstImage.size = CGSize (width: size.width * 2, height: size.height * 2)
        firstImage.zPosition = -1
    }
    
    

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
        return
    }
    let location = touch.location(in: self)
    
    let frontTouchedNode = self.atPoint(location)

    if (frontTouchedNode.name == "buttonFoward") {
        let newScene = NewScene(size: self.size)
                       
        let pushTransition = SKTransition.push(with: SKTransitionDirection(rawValue: 3)!, duration: 1.0)
        view?.presentScene(newScene, transition: pushTransition)
    }
}
}
