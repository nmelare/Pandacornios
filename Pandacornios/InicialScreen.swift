//
//  GameScene.swift
//  Pandacornios
//
//  Created by Nathalia Melare & Luiza Fattori on 09/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit

class InicialScreen: SKScene {
    
    var background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    var hiddenNodeGenius: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    var hiddenNodeSnake: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    var hiddenNodeSpaceInvaders: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    
    override func sceneDidLoad() {
        self.backgroundSetUp()
        if !MiniGamesController.shared.geniusWasPlayed {
            self.hiddeNodeGeniusSetUp()
        } else {
            print("Genius não foi instanciado")
        }
        if !MiniGamesController.shared.spaceInvadersWasPlayed {
            self.hiddeNodeSpaceInvadersSetUp()
        } else {
            print("Space não foi instanciado")
        }
        if !MiniGamesController.shared.snakeWasPlayed {
            self.hiddeNodeSnakeSetUp()
        } else {
            print("Snake não foi instanciado")
        }
    }
    
    func backgroundSetUp() {
        self.addChild(background)
        background.name = "Background"
        background.size = CGSize (width: size.height * 1, height: size.width * 1)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zRotation = (.pi / 2)
    }
    
    func hiddeNodeGeniusSetUp() {
        self.addChild(hiddenNodeGenius)
        hiddenNodeGenius.size = CGSize (width: size.height * 0.05, height: size.width * 0.1)
        hiddenNodeGenius.position = CGPoint(x: size.width * 0.8 , y: size.height * 0.3)
        hiddenNodeGenius.zPosition = +1
        hiddenNodeGenius.alpha = 1
    
       }
    
    func hiddeNodeSnakeSetUp() {
            self.addChild(hiddenNodeSnake)
           hiddenNodeSnake.size = CGSize (width: size.height * 0.06, height: size.width * 0.15)
           hiddenNodeSnake.position = CGPoint(x: size.width * 0.43 , y: size.height * 0.47)
        hiddenNodeSnake.alpha = 0.01
       
          }
    
    func hiddeNodeSpaceInvadersSetUp() {
            self.addChild(hiddenNodeSpaceInvaders)
        hiddenNodeSpaceInvaders.size = CGSize (width: size.height * 0.06, height: size.width * 0.2)
        hiddenNodeSpaceInvaders.position = CGPoint(x: size.width * 0.35 , y: size.height * 0.3)
        hiddenNodeSpaceInvaders.alpha = 1
       
          }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)

        let frontTouchedNode = self.atPoint(location)
        
        if (frontTouchedNode.contains(hiddenNodeGenius.position)) {
            let geniusScene = GeniusScene(size: self.size)
            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(geniusScene, transition: doorsClose)

        }
        
        if (frontTouchedNode.contains(hiddenNodeSnake.position)) {

            let snakeScene = GameSnake(size: self.size)

            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(snakeScene, transition: doorsClose)

        }

        if (frontTouchedNode.contains(hiddenNodeSpaceInvaders.position)) {

            let spaceScene = SpaceInvaders(size: self.size)

            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(spaceScene, transition: doorsClose)
            
        }
    }
}
