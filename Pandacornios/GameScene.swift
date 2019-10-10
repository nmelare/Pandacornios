//
//  GameScene.swift
//  Pandacornios
//
//  Created by Nathalia Melare on 09/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var vase: SKSpriteNode = SKSpriteNode(imageNamed: "vaso")
    
    override func sceneDidLoad() {
        self.physicsVase()
        backgroundColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
//    override func didMove(to view: SKView) {
//        self.physicsVase()
//        backgroundColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
//        }
        
    func physicsVase() {
        self.addChild(vase)
        print(vase.position)
        vase.name = "vaso"
        vase.size = CGSize (width: size.width * 0.15, height: size.height * 0.06)
        vase.position = CGPoint(x: size.width/2,   y: size.height/2)
        vase.isUserInteractionEnabled = false
    }
    
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            // ignore
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        print(location)
        
        let touchedNodes = nodes(at: location)
        let frontTouchedNode = self.atPoint(location)

        if (frontTouchedNode.name == "vaso") {
            let newScene = NewScene(size: self.size)
                           
            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(newScene, transition: doorsClose)
        }
        
        
    }
}
