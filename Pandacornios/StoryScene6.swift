//
//  StoryScene6.swift
//  Pandacornios
//
//  Created by Julia Santos on 23/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit

class StoryScene6: SKScene {
    
    var buttonBack : SKSpriteNode = SKSpriteNode(imageNamed: "back_button")
    var firstImage: SKSpriteNode = SKSpriteNode(imageNamed: "ilustracao_06")
    
    override func sceneDidLoad() {
        self.buttonBackSetUp()
        self.firstImageSetUp()
    }
    
    func buttonBackSetUp() {
        self.addChild(buttonBack)
        buttonBack.name = "buttonBack"
        buttonBack.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        buttonBack.zRotation = (.pi/2)
        buttonBack.isUserInteractionEnabled = false
    }
    
    
    func  firstImageSetUp() {
        self.addChild(firstImage)
        firstImage.size = CGSize(width: size.width * 1.3, height: size.height * 0.5)
        firstImage.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        firstImage.zPosition = -1
        firstImage.zRotation = (.pi/2)
    }

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
        return
    }
    let location = touch.location(in: self)
    
    let frontTouchedNode = self.atPoint(location)

    if (frontTouchedNode.name == "buttonBack") {
        let newScene = StoryScene5(size: self.size)
                       
        let pushTransition = SKTransition.push(with: SKTransitionDirection(rawValue: 4)!, duration: 1.0)
        view?.presentScene(newScene, transition: pushTransition)
    }
}
}
