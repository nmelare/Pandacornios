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
    
   // MARK: Variables
    var highScore: SKLabelNode!
    var game: GameManagerSnake!
    var currentScore: SKLabelNode!
    var playerPositions: [(Int, Int)] = []
    var gameBackground: SKShapeNode!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    var scorePos: CGPoint?
    var gameEnding: Bool = false
    var contentCreated = false
    
    
     // MARK: Call functions
    override func didMove(to view: SKView) {
        game = GameManagerSnake(scene: self)
        startGame()
        initializeGameView()
      
        
    // MARK: Swipe directions (the directions the snake can go with just the touch)
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeR))
        swipeRight.direction = .right
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeL))
        swipeLeft.direction = .left
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeU))
        swipeUp.direction = .down
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeD))
        swipeDown.direction = .up

    // MARK: Implementation of these swipes
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    // MARK: Set up Highscore
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
        
    // MARK: Highscore - action
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
    
    
    // MARK: Current Score and background
    private func initializeGameView() {
        
    // MARK: Set up current score
        currentScore = SKLabelNode(fontNamed: "Silkscreen Expanded")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x:frame.size.width - 110, y: size.height - (80 + currentScore.frame.size.height/2))
        currentScore.fontSize = 20
        currentScore.isHidden = true
        currentScore.text = "Score: 0"
        currentScore.fontColor = #colorLiteral(red: 1, green: 0.7234264016, blue: 0.8472076058, alpha: 1)
        currentScore.isHidden = true
        
    // MARK: Size
        let width = Int(frame.size.width)
        let height = Int(frame.size.height)
        let rect = CGRect(x: width - width + 25, y: height - height + 25 , width: width - 50, height: height - height/20)
        
    // MARK: Set up Game Background
        gameBackground = SKShapeNode(rect: rect, cornerRadius: 20)
        gameBackground.fillColor = SKColor.clear
        gameBackground.zPosition = 2
        gameBackground.isHidden = true
        
        
    // MARK: Add them
        self.addChild(currentScore)
        self.addChild(gameBackground)

        createGameBoard(width: width, height: height)
    }
    
    // MARK: Scene creation
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
    // MARK: go to Game Over screen
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
