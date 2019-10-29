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
    var hiddenNodeBox: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    
    override func sceneDidLoad() {
        self.backgroundSetUp()
        self.hiddenNodeBoxSetUp()

        if !MiniGamesController.shared.geniusWasPlayed {
            self.hiddeNodeGeniusSetUp()
        }

        if !MiniGamesController.shared.spaceInvadersWasPlayed {
            self.hiddeNodeSpaceInvadersSetUp()
        }

        if !MiniGamesController.shared.snakeWasPlayed {
            self.hiddeNodeSnakeSetUp()
        }
        
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
        hiddenNodeGenius.zPosition = +1
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

    func hiddenNodeBoxSetUp() {
        self.addChild(hiddenNodeBox)

        hiddenNodeBox.size = CGSize (width: size.height * 0.1, height: size.width * 0.35)
        hiddenNodeBox.position = CGPoint(x: size.width * 0.9, y: size.height * 0.09)
        hiddenNodeBox.zPosition = +1
        hiddenNodeBox.alpha = 0.01
    }

    public func messageSetUp() {

        let labelNotEndYet = SKLabelNode(fontNamed: "Galvji")

        labelNotEndYet.text = "Você ainda não guardou seus jogos na caixa"
        labelNotEndYet.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        labelNotEndYet.fontColor = SKColor.black
        labelNotEndYet.fontSize = 27
        labelNotEndYet.zPosition = +1
        labelNotEndYet.zRotation = (.pi/2)

        self.addChild(labelNotEndYet)

        let backgroundFromMessage = SKSpriteNode()
        backgroundFromMessage.color = SKColor.yellow
        backgroundFromMessage.size = CGSize(width: 40, height: UIScreen.main.bounds.size.height
             - 40)
        backgroundFromMessage.position = CGPoint(x: labelNotEndYet.frame.midX, y: labelNotEndYet.frame.midY)
        backgroundFromMessage.zPosition = +1
//        backgroundFromMessage.zRotation = (.pi/2)

        self.addChild(backgroundFromMessage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)

        if (hiddenNodeGenius.contains(location)) {
            let geniusScene = GeniusScene(size: self.size)
            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(geniusScene, transition: doorsClose)

        }

        if (hiddenNodeSnake.contains(location)) {
            let snakeScene = GameSnake(size: self.size)

            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(snakeScene, transition: doorsClose)

        }

        if (hiddenNodeSpaceInvaders.contains(location)) {
            let spaceScene = SpaceInvaders(size: self.size)

            let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(spaceScene, transition: doorsClose)
            
        }

        if (hiddenNodeBox.contains(location)) && MiniGamesController.shared.geniusWasPlayed == true && MiniGamesController.shared.snakeWasPlayed == true && MiniGamesController.shared.spaceInvadersWasPlayed == true {
            let endStory = StoryScene4(size: self.size)

            let doorClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
            view?.presentScene(endStory, transition: doorClose)

        } else {
            messageSetUp()
            }
    }
}
