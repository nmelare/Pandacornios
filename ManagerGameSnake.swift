//
//  ManagerGameSnake.swift
//  Pandacornios
//
//  Created by Rayane Xavier on 23/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameManagerSnake {
    
    // MARK: Variables
    var scene: GameSnake!
    // nextTime is the nextTime interval we will print a statement to the console
    var nextTime: Double?
    // timeExtension is how long we will wait between each print (1 second).
    var timeExtension: Double = 0.15
    // player’s current direction.
    var playerDirection: Int = 4
    var currentScore: Int = 0
    let defaults = UserDefaults.standard
    
    let width = Int(UIScreen.main.bounds.width)
    let height = Int(UIScreen.main.bounds.height)

    // MARK: Creating a game instance
    init(scene: GameSnake) {
        self.scene = scene
    }
    
    // MARK: This adds 3 coordinates to the GameScene’s playerPositions array,
    func initGame() {
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((10, 11))
        scene.playerPositions.append((10, 12))
        renderChange()
        
        // Call the function inside the initGame() function that will generate a new random point.
        generateNewPoint()
    }
    
    // MARK: This function generates a random position within the bounds of the board (20/40), arrays start counting at 0 so we count from 0 to 19 and from 0 to 39, this is a 20x40 array.
    private func generateNewPoint() {
        var randX = CGFloat(Int.random(in: 0...width/22))
        var randY = CGFloat(Int.random(in: 0...height/22))
    
    // ensure that a point is not generated inside the body of the snake. As the snake grows in length we will be more likely to run into this problem, so this code block should fix that issue.
        while contains(a: scene.playerPositions, v: (Int(randX), Int(randY))) {
            randX = CGFloat(Int.random(in: 0...width/22))
            randY = CGFloat(Int.random(in: 0...height/22))
        }
        
        scene.scorePos = CGPoint(x: randX, y: randY)
    }
    
   // MARK: This function checks if a scorePos has been set, if it has then it checks the head of the snake. If the snake is touching a point then the score is iterated, the text label showing the score is updated and a new point is generated.
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
    
    // MARK: Check if the player’s head has collided with any of the tail positions. If player has died then set playerDirection to 0.
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
    
    //  This function will check for the completion of the snake’s final animation when it closes in on itself. Once all positions in the playerPositions array match each other the snake has shrunk to one square. After this occurs we set the playerDirection to 4 (it was previously set to 0 indicating death) and then we show the menu objects. We also hide the currentScore label and gameBG object (the grid of squares)
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
                
        // in this iteration we are calling the update every second
                updatePlayerPosition()
                checkForScore()
                checkForDeath()
                finishAnimation()
            }
        }
    }
    
    // MARK: This method moves the player or “snake” around the screen
    private func updatePlayerPosition() {
    // Set variables to determine the change we should make to the x/y of the snake’s front
        var xChange = -1
        var yChange = 0
        
   // MARK: This is a switch statement, it takes the input of the playerPosition and modifies the x/y variables according to wether the player is moving up, down, left or right
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
        
    // MARK: This block of code moves the positions forwards in the array. We want to move the front of the tail in the appropriate direction and then move all the tail blocks forward to the next position
        if scene.playerPositions.count > 0 {
            var start = scene.playerPositions.count - 1
            
            while start > 0 {
                scene.playerPositions[start] = scene.playerPositions[start - 1]
                start -= 1
            }
            
            scene.playerPositions[0] = (scene.playerPositions[0].0 + yChange, scene.playerPositions[0].1 + xChange)
        }
        
    // MARK: it checks if the position of the head of the snake has passed the top, bottom, left side or right side and then moves the player to the other side of the screen.
        if scene.playerPositions.count > 0 {
            let x = scene.playerPositions[0].1
            let y = scene.playerPositions[0].0
            
            if y > height/22 {
                scene.playerPositions[0].0 = 0
            } else if y < 0 {
                scene.playerPositions[0].0 = height/22
            } else if x > width/22 {
                scene.playerPositions[0].1 = 0
            } else if x < 0 {
                scene.playerPositions[0].1 = width/22
            }
        }
        // Render the changes we made to the array of positions.
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
    
    // MARK: We will call this method every time we move the “snake” or player
    // PS:  the top left corner is 0,0 and the bottom right corner is 39,19.
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
