//
//  Genius.swift
//  Pandacornios
//
//  Created by Luiza Fattori on 10/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVKit

class GeniusScene: SKScene {

    var toque = 0

    var playerTurn: Bool = false
    // Atlas
    var redRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "redRetangle")
    var yellowRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "yellowRetangle")
    var greenRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "greenRetangle")
    var blueRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "blueRetangle")

    // Nodes
    var redRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "redRetangleOff")
    var yellowRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "yellowRetangleOff")
    var greenRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "greenRetangleOff")
    var blueRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "blueRetangleOff")
    var buttonPlay: SKSpriteNode = SKSpriteNode(imageNamed: "coin_00")

    // Arrays
    var buttonsOptions: [SKSpriteNode] = []
    var gameSequel: [SKSpriteNode] = []
    var playerSequel: [SKSpriteNode] = []

    //Quando a cena carregar, você faz isso:
    override func sceneDidLoad() {

        self.setUpRedRetangelOff()
        self.setUpBlueRetangelOff()
        self.setUpGreenRetangelOff()
        self.setUpYellowRetangelOff()
        self.setUpPlayButton()

        self.buttonsOptions = [blueRetangleOff, redRetangleOff, yellowRetangleOff, greenRetangleOff]
    }

    func setUpRedRetangelOff() {
        self.addChild(redRetangleOff)
        redRetangleOff.position = CGPoint(x: size.width / 2.5, y: size.height * 0.55)
        redRetangleOff.name = "RedButton"
    }

    func setUpYellowRetangelOff() {
        self.addChild(yellowRetangleOff)
        yellowRetangleOff.position = CGPoint(x: size.width / 2.5, y: size.height * 0.45)
        yellowRetangleOff.name = "YellowButton"
    }

    func setUpGreenRetangelOff() {
        self.addChild(greenRetangleOff)
        greenRetangleOff.position = CGPoint(x: size.width / 1.65, y: size.height * 0.55)
        greenRetangleOff.name = "GreenButton"
    }

    func setUpBlueRetangelOff() {
        self.addChild(blueRetangleOff)
        blueRetangleOff.position = CGPoint(x: size.width / 1.65, y: size.height * 0.45)
        blueRetangleOff.name = "BlueButton"
    }

    func setUpPlayButton() {
        self.addChild(buttonPlay)
        buttonPlay.position = CGPoint(x: size.width / 2, y: size.height / 1.5)
        buttonPlay.size = CGSize(width: size.width / 4, height: size.height / 4)
        buttonPlay.name = "PlayButton"
    }

    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set { // quando ignoramos o toque

        }
    }

    func playGame() {
        let elementOfTheSequel = buttonsOptions.randomElement()
        gameSequel.append(elementOfTheSequel!)

    }

    func animate( animatedRetangles: [SKSpriteNode]) {

        for rect in animatedRetangles {
            var textureOfRetangles:[SKTexture] = []
            if let retangleTexture = rect.texture {
//                paramos aqui.
                func loadFrames(_ textureAtlas: SKTextureAtlas) -> [SKTexture] {

                    var frames = [SKTexture]()
                    let names = textureAtlas.textureNames.sorted()

                    for i in 0...names.count-1 {
                        let t = textureAtlas.textureNamed(names[i])
                        t.filteringMode = .nearest
                        frames.append(t)
                    }
                    return frames
                }//AQUI
                textureOfRetangles.append(retangleTexture)
            }

            let action = SKAction.animate(withNormalTextures: textureOfRetangles, timePerFrame: 0.5, resize: false, restore: true)
            rect.run(action) {
                self.playerTurn = true
                self.resetPlayerGameSequel()
                print("Go player")
            }
        }

    }

    func animateSequel() {
        self.animate(animatedRetangles: gameSequel)
    }

    func resetGame() {
        gameSequel = []
        playerSequel = []
    }

    func resetPlayerGameSequel() {
        playerSequel = []
    }
// Se o toque começou
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first
            else {
                return
        }

        let location = touch.location(in: self)

        guard let frontTouchedNode = self.atPoint(location) as? SKSpriteNode else { return }

        if frontTouchedNode.name == "PlayButton" {
            self.resetGame()
            self.playGame()
            self.animateSequel()
            print("Passou do start")
        } else {
            return
        }
        if playerTurn == true {
            if buttonsOptions.contains(frontTouchedNode) {
                if frontTouchedNode == redRetangleOff {
                    animate(animatedRetangles: [redRetangleOff])
                }
                if frontTouchedNode == blueRetangleOff {
                    animate(animatedRetangles: [blueRetangleOff])
                }
                if frontTouchedNode == yellowRetangleOff {
                    animate(animatedRetangles: [yellowRetangleOff])
                }
                if frontTouchedNode == greenRetangleOff {
                    animate(animatedRetangles: [greenRetangleOff])
                }
                playerSequel.append(frontTouchedNode)

                if playerSequel[toque] == gameSequel[toque] {
                    toque += 1
                } else {
//                    som de perdeu
                    resetPlayerGameSequel()
                    resetGame()
                }

            }
        } else {
            isUserInteractionEnabled = false
            self.animateSequel()
        }

    }
}
