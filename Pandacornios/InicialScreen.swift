//
//  GameScene.swift
//  Pandacornios
//
//  Created by Nathalia Melare on 09/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit

class InicialScreen: SKScene {
    
    var background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    var hiddenNodeGenius: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    var hiddenNodeSnake: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    var hiddenNodeSpaceInvaders: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    var touchOnGames: Int = 0
    
    override func sceneDidLoad() {
        self.backgroundSetUp()
        self.hiddeNodeGeniusSetUp()
        self.hiddeNodeSpaceInvadersSetUp()
        self.hiddeNodeSnakeSetUp()
    }
    
    func backgroundSetUp() {
        self.addChild(background)
        background.name = "Background"
        background.size = CGSize (width: size.height * 1, height: size.width * 1)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zRotation = (.pi / 2)
        background.alpha = 0.99
    }
    
    func hiddeNodeGeniusSetUp() {
           self.addChild(hiddenNodeGenius)
        hiddenNodeGenius.size = CGSize (width: size.height * 0.05, height: size.width * 0.1)
        hiddenNodeGenius.position = CGPoint(x: size.width * 0.8 , y: size.height * 0.3)
        hiddenNodeGenius.alpha = 0.01
    
       }
    
    func hiddeNodeSnakeSetUp() {
              self.addChild(hiddenNodeSnake)
           hiddenNodeSnake.size = CGSize (width: size.height * 0.06, height: size.width * 0.15)
           hiddenNodeSnake.position = CGPoint(x: size.width * 0.43 , y: size.height * 0.47)
        hiddenNodeSnake.alpha = 0.01
       
          }
    
    func hiddeNodeSpaceInvadersSetUp() {
            self.addChild(hiddenNodeSpaceInvaders)
        hiddenNodeSpaceInvaders.size = CGSize (width: size.height * 0.06, height: size.width * 0.20)
        hiddenNodeSpaceInvaders.position = CGPoint(x: size.width * 0.35 , y: size.height * 0.30)
        hiddenNodeSpaceInvaders.alpha = 0.01
       
          }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        if (hiddenNodeGenius.contains(location)) {
            touchOnGames += 1
            let geniusScene = GeniusScene(size: self.size)
                           
            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(geniusScene, transition: doorsClose)
            print(touchOnGames)
        }
        
        if (hiddenNodeSnake.contains(location)) {
            touchOnGames += 1
            let snakeScene = GameSnake(size: self.size)

            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(snakeScene, transition: doorsClose)
            print(touchOnGames)
        }

        if (hiddenNodeSpaceInvaders.contains(location)) {
            touchOnGames += 1
            let spaceScene = SpaceInvaders(size: self.size)

            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(spaceScene, transition: doorsClose)
            print(touchOnGames)
        }
        
        if touchOnGames == 3 {
            print("Foi")
        }
   
    }
}
