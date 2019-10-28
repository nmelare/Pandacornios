//
//  ManagerGameSnake.swift
//  Pandacornios
//
//  Created by Rayane Xavier on 23/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit

class GameManagerSnake {
    var scene: GameSnake!
    var nextTime: Double?
    var timeExtension: Double = 0.15
    var playerDirection: Int = 4
    var currentScore: Int = 0
    let defaults = UserDefaults.standard
    
    init(scene: GameSnake) {
        self.scene = scene
    }
    
    func initGame() {
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((10, 11))
        scene.playerPositions.append((10, 12))
        
        renderChange()
        
        generateNewPoint()
    }
    
    private func generateNewPoint() {
        var randX = CGFloat(Int.random(in: 0...19))
        var randY = CGFloat(Int.random(in: 0...39))
        
        while contains(a: scene.playerPositions, v: (Int(randX), Int(randY))) {
            randX = CGFloat(Int.random(in: 0...19))
            randY = CGFloat(Int.random(in: 0...39))
        }
        
        scene.scorePos = CGPoint(x: randX, y: randY)
    }
    
    private func checkForScore() {
        if scene.scorePos != nil {
            let x = scene.playerPositions[0].0
            let y = scene.playerPositions[0].1
            
            if Int((scene.scorePos?.x)!) == y && Int((scene.scorePos?.y)!) == x {
                currentScore += 1
                scene.currentScore.text = "Score: \(currentScore)"
                generateNewPoint()
                
                scene.playerPositions.append(scene.playerPositions.last!)
                scene.playerPositions.append(scene.playerPositions.last!)
                
            }
        }
    }
    
    private func checkForDeath() {
        if scene.playerPositions.count > 0 {
            var arrayOfPositions = scene.playerPositions
            let headOfSnake = arrayOfPositions[0]
            
            arrayOfPositions.remove(at: 0)
            
            if contains(a: arrayOfPositions, v: headOfSnake) {
                playerDirection = 0
            }
        }
    }
    
    private func finishAnimation() {
        if playerDirection == 0 && scene.playerPositions.count > 0 {
            var hasFinished = true
            let headOfSnake = scene.playerPositions[0]
            
            for position in scene.playerPositions {
                if headOfSnake != position {
                    hasFinished = false
                }
            }
            
            if hasFinished {
                updateScore()
                playerDirection = 4
                scene.scorePos = nil
                scene.playerPositions.removeAll()
                renderChange()
             self.scene.endGame()
                }
        }
    }
    
    func update(time: Double) {
        if nextTime == nil {
            nextTime = time + timeExtension
        } else {
            if time >= nextTime! {
                nextTime = time + timeExtension
                updatePlayerPosition()
                checkForScore()
                checkForDeath()
                finishAnimation()
            }
        }
    }
    
    private func updatePlayerPosition() {
        var xChange = -1
        var yChange = 0
        
        switch playerDirection {
        case 1:// left
            xChange = -1
            yChange = 0
        case 2:// up
            xChange = 0
            yChange = -1
        case 3:// right
            xChange = 1
            yChange = 0
        case 4:// down
            xChange = 0
            yChange = 1
        case 0:// death
            xChange = 0
            yChange = 0
        default:
            break
        }
        
        if scene.playerPositions.count > 0 {
            var start = scene.playerPositions.count - 1
            
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            
            scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
        }
        
        if scene.playerPositions.count > 0 {
            let x = scene.playerPositions[0].1
            let y = scene.playerPositions[0].0
            
            if y > 40 {
                scene.playerPositions[0].0 = 0
            } else if y < 0 {
                scene.playerPositions[0].0 = 40
            } else if x > 20 {
                scene.playerPositions[0].1 = 0
            } else if x < 0 {
                scene.playerPositions[0].1 = 20
            }
        }
        
        renderChange()
    }
    
    private func updateScore() {
        if currentScore > defaults.integer(forKey: "highScore") {
            defaults.set(currentScore, forKey: "highScore")
        }
        
        currentScore = 0
        scene.currentScore.text = "Score: 0"
        scene.highScore.text = "High Score: \(defaults.integer(forKey: "highScore"))"
       scene.currentScore.isHidden = true
    }
    
    func renderChange() {
        for (node, x, y) in scene.gameArray {
            if contains(a: scene.playerPositions, v: (x, y)) {
                node.fillColor = #colorLiteral(red: 0.7843137255, green: 0.8235294118, blue: 0, alpha: 1)
            } else {
                node.fillColor = SKColor.clear
                
                // Apple
                if scene.scorePos != nil {
                    if Int((scene.scorePos?.x)!) == y && Int((scene.scorePos?.y)!) == x {
                        node.fillColor = #colorLiteral(red: 1, green: 0.737254902, blue: 0.8431372549, alpha: 1)
                    }
                }
            }
        }
    }
    
    func contains(a:[(Int, Int)], v:(Int,Int)) -> Bool {
        let (c1, c2) = v
        
        for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true } }
        return false
    }
    
    // Declaration of functions
    func swipe(ID: Int) {
        if !(ID == 2 && playerDirection == 4) && !(ID == 4 && playerDirection == 2) {
            if !(ID == 1 && playerDirection == 3) && !(ID == 3 && playerDirection == 1) {
                if playerDirection != 0 {
                    playerDirection = ID
                }
            }
        }
    }
}
