//
//  SnakeGame.swift
//  Pandacornios
//
//  Created by Rayane Xavier on 23/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameSnake: SKScene {
    
   // Variables
    var highScore: SKLabelNode!
    var game: GameManagerSnake!
    var currentScore: SKLabelNode!
    var playerPositions: [(Int, Int)] = []
    var gameBackground: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    var scorePos: CGPoint?
    var gameEnding: Bool = false
    var contentCreated = false
    var quitButton: SKSpriteNode = SKSpriteNode(imageNamed: "quit_button")
    
    override func didMove(to view: SKView) {
     //   self.physicsWorld.contactDelegate = self
     //   initializeMenu()
        game = GameManagerSnake(scene: self)
          startGame()
        initializeGameView()
        self.setUpQuitButton()
      
      
        
        // Swipe directions (the directions the snake can go with just the touch)
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeR))
        swipeRight.direction = .right
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeL))
        swipeLeft.direction = .left
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeU))
        swipeUp.direction = .down
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeD))
        swipeDown.direction = .up

        // Implementation of this swipe
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeR() {
        game.swipe(ID: 3)
    }
    @objc func swipeL() {
        game.swipe(ID: 1)
    }
    @objc func swipeU() {
        game.swipe(ID: 2)
    }
    @objc func swipeD() {
        game.swipe(ID: 4)
    }
//    override func sceneDidLoad() {
//        self.setUpQuitButton()
//    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first
            else {
                return
        }

        let location = touch.location(in: self)

        guard let frontTouchedNode = self.atPoint(location) as? SKSpriteNode else { return }

        if frontTouchedNode.name == "QuitButton" {
            let gameScene = InicialScreen(size: self.size)
            self.view?.presentScene(gameScene,transition: SKTransition.doorsOpenVertical(withDuration: 1.0))
        }
    }
    
    private func startGame() {
        let bottomCorner = CGPoint(x: 0, y: (frame.size.height / -2) + 20)
        
        highScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        highScore.zPosition = 1
        highScore.position = CGPoint(x: 0, y: self.frame.midY - 170)
        highScore.fontSize = 100
        highScore.text = "High Score: \(UserDefaults.standard.integer(forKey: "highScore"))"
        highScore.fontColor = SKColor.white
        highScore.isHidden = true
        
        self.addChild(highScore)
        
        highScore.run(SKAction.move(to: bottomCorner, duration: 0.4)) {
            self.gameBackground.setScale(0)
            self.currentScore.setScale(0)
            self.gameBackground.isHidden = false
            self.currentScore.isHidden = false
            self.gameBackground.run(SKAction.scale(to: 1, duration: 0.4))
            self.currentScore.run(SKAction.scale(to: 1, duration: 0.4))

            self.game.initGame()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        game.update(time: currentTime)
    }
    
    
    // Current Score and background
    private func initializeGameView() {
        currentScore = SKLabelNode(fontNamed: "Silkscreen Expanded")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x:frame.size.width - 110, y: size.height - (80 + currentScore.frame.size.height/2))
        currentScore.fontSize = 20
        currentScore.isHidden = true
        currentScore.text = "Score: 0"
        currentScore.fontColor = #colorLiteral(red: 1, green: 0.7234264016, blue: 0.8472076058, alpha: 1)
        currentScore.isHidden = true
        
        let width = Int(frame.size.width)
        let height = Int(frame.size.height)
        let rect = CGRect(x: width - width + 25, y: height - height + 25 , width: width - 50, height: height - height/20)
        
        gameBackground = SKShapeNode(rect: rect, cornerRadius: 20)
        gameBackground.fillColor = SKColor.clear
        
        gameBackground.zPosition = 2
        gameBackground.isHidden = true
        
        self.addChild(currentScore)
        self.addChild(gameBackground)

        createGameBoard(width: width, height: height)
    }
    
    // Scene creation
    private func createGameBoard(width: Int, height: Int) {
        let numCols = 20
        let numRows = height/22
        let cellWidth: CGFloat = CGFloat(width - 75) / CGFloat(numCols)
        
        var x = CGFloat(width - width + 45)
        var y = CGFloat(height - height + 48)

        for i in 0...numRows - 1 {
            for j in 0...numCols - 1 {
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                cellNode.strokeColor = SKColor.darkGray
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)

                gameArray.append((node: cellNode, x: i, y: j))
                gameBackground.addChild(cellNode)

                x += cellWidth
            }

            x = CGFloat(width - width + 45)
            y += CGFloat(height - height + 18)
        }
    }

    func setUpQuitButton() {
        self.addChild(quitButton)
        quitButton.position = CGPoint(x: size.width * 0.17, y: size.height * 0.915)
        quitButton.size = CGSize (width: size.width * 0.15, height: size.height * 0.085)
        quitButton.name = "QuitButton"
        quitButton.zPosition = +2
    }
    
    func endGame() {
       // 1
       if !gameEnding {
         
         gameEnding = true
         
         // 2
         let gameOverScene: GameOverSceneSnake = GameOverSceneSnake(size: size)
         
         view?.presentScene(gameOverScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 1.0))
       }
     }
}
