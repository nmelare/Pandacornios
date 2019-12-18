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
    
    var buttonFoward: SKSpriteNode = SKSpriteNode(imageNamed: "foward_button")
    var firstImage: SKSpriteNode = SKSpriteNode(imageNamed: "ilustracao_01")

    override func sceneDidLoad() {
        self.buttonFowardSetUp()
        self.firstImageSetUp()
        MusicHelper.shared.setup()
    }
    
    func buttonFowardSetUp() {
        self.addChild(buttonFoward)
        buttonFoward.name = "buttonFoward"
        buttonFoward.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        buttonFoward.zRotation = (.pi/2)
        buttonFoward.isUserInteractionEnabled = false
    }

    func  firstImageSetUp() {
        self.addChild(firstImage)
        firstImage.size = CGSize(width: UIScreen.main.bounds.width * 1.3, height: UIScreen.main.bounds.height * 0.6)
        firstImage.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        firstImage.zPosition = -1
        firstImage.zRotation = (.pi / 2)
    }

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
        return
    }
    let location = touch.location(in: self)
    
    let frontTouchedNode = self.atPoint(location)

    if (frontTouchedNode.name == "buttonFoward") {
        let newScene = StoryScene2(size: self.size)
                       
        let pushTransition = SKTransition.push(with: SKTransitionDirection(rawValue: 1)!, duration: 1.0)
        view?.presentScene(newScene, transition: pushTransition)
    }
}
}
