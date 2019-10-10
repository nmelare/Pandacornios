//
//  TouchScene.swift
//  Pandacornios
//
//  Created by Nathalia Melare on 09/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit

class NewScene: SKScene {
    override func didMove(to view: SKView) {
        self.goBackLabel()
    }
    
    func goBackLabel() {
        let goBackLabel = SKLabelNode(text: "Go Back")
        goBackLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        goBackLabel.fontSize = 70
        addChild(goBackLabel)
        goBackLabel.isUserInteractionEnabled = false
        goBackLabel.name = "goBackLabel"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       guard let touch = touches.first else {
                return
            }
            
            let location = touch.location(in: self)
            
            let touchedNodes = nodes(at: location)
            let frontTouchedNode = self.atPoint(location)
        
        if (frontTouchedNode.name == "goBackLabel") {
            let scene = GameScene(size: self.size)

            let doorsOpen = SKTransition.doorsOpenVertical(withDuration: 1.0)
            view?.presentScene(scene, transition: doorsOpen)
        }
    }

}

