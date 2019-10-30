//
//  GameOverScene.swift
//  Pandacornios
//
//  Created by Rayane Xavier on 23/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
  
  var contentCreated = false
  
  override func didMove(to view: SKView) {
    
    if (!self.contentCreated) {
      self.createContent()
      self.contentCreated = true
    }
  }
  
  func createContent() {
    
    let gameOverLabel = SKLabelNode(fontNamed: "Galvji")
    gameOverLabel.fontSize = 50
    gameOverLabel.fontColor = #colorLiteral(red: 0.7843137255, green: 0.8235294118, blue: 0, alpha: 1)
    gameOverLabel.text = "Game"
    gameOverLabel.fontName = "Silkscreen Expanded"
    gameOverLabel.position = CGPoint(x: self.size.width/2, y: 2.0 / 3.0 * self.size.height);
    
    self.addChild(gameOverLabel)
    
    let gameOverLabel2 = SKLabelNode(fontNamed: "Galvji")
    gameOverLabel2.fontSize = 50
    gameOverLabel2.fontColor = SKColor.white
    gameOverLabel2.text = "Over!"
    gameOverLabel2.fontName = "Silkscreen Expanded"
    gameOverLabel2.position = CGPoint(x: self.size.width/2, y: 2.0 / 3.5 * self.size.height);
    
    self.addChild(gameOverLabel2)
    
    let labelReturnGame = SKLabelNode(fontNamed: "Galvji")
    labelReturnGame.fontSize = 17
    labelReturnGame.fontColor = SKColor.black
    labelReturnGame.text = "Jogar novamente"
    labelReturnGame.position = CGPoint(x: self.size.width/2, y: gameOverLabel.frame.origin.y - gameOverLabel.frame.size.height - 200);
    
    self.addChild(labelReturnGame)
    
    let buttonReturnGame = SKSpriteNode()
    buttonReturnGame.name = "btn"
    buttonReturnGame.color = #colorLiteral(red: 0.7843137255, green: 0.8235294118, blue: 0, alpha: 1)
    buttonReturnGame.size.height = 30
    buttonReturnGame.size.width = UIScreen.main.bounds.size.width - 40
    buttonReturnGame.position = CGPoint(x: labelReturnGame.frame.midX, y: labelReturnGame.frame.midY)
    
    self.addChild(buttonReturnGame)

    let labelReturnMain = SKLabelNode(fontNamed: "Galvji")
    labelReturnMain.fontSize = 17
    labelReturnMain.fontColor = SKColor.black
    labelReturnMain.text = "Voltar para o quarto"
    labelReturnMain.position = CGPoint(x: self.size.width/2, y: gameOverLabel.frame.origin.y - gameOverLabel.frame.size.height - 250);
    
    self.addChild(labelReturnMain)
    
    let buttonReturnMain = SKSpriteNode()
    buttonReturnMain.name = "btn2"
    buttonReturnMain.color = #colorLiteral(red: 0.7843137255, green: 0.8235294118, blue: 0, alpha: 1)
    buttonReturnMain.size.height = 30
    buttonReturnMain.size.width = UIScreen.main.bounds.size.width - 40
    buttonReturnMain.position = CGPoint(x: labelReturnGame.frame.midX, y: labelReturnMain.frame.midY)
    
    self.addChild(buttonReturnMain)
    
    // black space color
    self.backgroundColor = SKColor.black
    
  }
  
    
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    let positionInScene = touch!.location(in: self)
    let touchedNode = self.atPoint(positionInScene)



    if let name = touchedNode.name {
        if name == "btn" {

            let gameScene = GameSnake(size: self.size)
            gameScene.scaleMode = .aspectFill

            self.view?.presentScene(gameScene)
            


          }
        if name == "btn2"{
            let gameScene = InicialScreen(size: self.size)
            gameScene.scaleMode = .aspectFill

            self.view?.presentScene(gameScene)
        }
      }
  }
    
    
    
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)  {
    
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)  {

    
  }

}

