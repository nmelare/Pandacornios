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
    var redRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "redButton")
    var yellowRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "yellowButton")
    var greenRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "greenButton")
    var blueRetangleAtlas: SKTextureAtlas = SKTextureAtlas(named: "blueButton")

    // Nodes
    var redRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "redButton")
    var yellowRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "yellowButton")
    var greenRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "greenButton")
    var blueRetangleOff: SKSpriteNode = SKSpriteNode(imageNamed: "blueButton")
    var buttonPlay: SKSpriteNode = SKSpriteNode(imageNamed: "play_button")

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
        redRetangleOff.position = CGPoint(x: size.width * 0.72, y: size.height * 0.67)
        redRetangleOff.size = CGSize(width: size.width * 0.42, height: size.height * 0.23)
        redRetangleOff.name = "RedButton"
    }

    func setUpYellowRetangelOff() {
        self.addChild(yellowRetangleOff)
        yellowRetangleOff.position = CGPoint(x: size.width * 0.3, y: size.height * 0.45)
        yellowRetangleOff.size = CGSize(width: size.width * 0.42, height: size.height * 0.23)
        yellowRetangleOff.name = "YellowButton"
    }

    func setUpGreenRetangelOff() {
        self.addChild(greenRetangleOff)
        greenRetangleOff.position = CGPoint(x: size.width * 0.3, y: size.height * 0.67)
        greenRetangleOff.size = CGSize(width: size.width * 0.42, height: size.height * 0.23)
        greenRetangleOff.name = "GreenButton"
    }

    func setUpBlueRetangelOff() {
        self.addChild(blueRetangleOff)
        blueRetangleOff.position = CGPoint(x: size.width * 0.72, y: size.height * 0.45)
        blueRetangleOff.size = CGSize(width: size.width * 0.42, height: size.height * 0.23)
        blueRetangleOff.name = "BlueButton"
    }

    func setUpPlayButton() {
        self.addChild(buttonPlay)
        buttonPlay.position = CGPoint(x: size.width * 0.55, y: size.height * 0.56)
        buttonPlay.size = CGSize(width: size.width / 7, height: size.height / 10)
        buttonPlay.name = "PlayButton"
    }

    //    override var isUserInteractionEnabled: Bool {
    //        get {
    //            return false
    //        }
    //        set { // quando ignoramos o toque
    //
    //        }
    //    }

    func playGame() {
        let elementOfTheSequel = buttonsOptions.randomElement()
        gameSequel.append(elementOfTheSequel!)

    }

    func animate(animatedRetangles: [SKSpriteNode], completion: @escaping () -> Void) {
        var actionList:[SKAction] = []
        for rect in animatedRetangles {
            var atlas = redRetangleAtlas
            if rect.name == "GreenButton"{
                atlas = greenRetangleAtlas
            } else if rect.name == "BlueButton"{
                atlas = blueRetangleAtlas
            } else if rect.name == "YellowButton"{
                atlas = yellowRetangleAtlas
            }

            let textureOfRetangles:[SKTexture] = loadFrames(atlas)
            let actionAndWait = SKAction.group([SKAction.run(SKAction.animate(with: textureOfRetangles, timePerFrame: 1 / TimeInterval(textureOfRetangles.count), resize: false, restore: true), onChildWithName: rect.name!),SKAction.wait(forDuration: 1.1)])
            actionList.append(actionAndWait)
        }
        run(SKAction.sequence(actionList), completion: completion)

    }


    func loadFrames(_ textureAtlas: SKTextureAtlas) -> [SKTexture] {

        var frames = [SKTexture]()
        let names = textureAtlas.textureNames.sorted()

        for i in 0...names.count-1 {
            let t = textureAtlas.textureNamed(names[i])
            t.filteringMode = .nearest
            frames.append(t)
        }
        return frames
    }

    func animateSequel() {
        self.animate(animatedRetangles: gameSequel) {
            self.playerTurn = true
            self.toque = 0
            self.resetPlayerGameSequel()
        }
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
            return
        }

        if playerTurn == true {
            print("cheguei")
            print(frontTouchedNode)
            if buttonsOptions.contains(frontTouchedNode) {
                //                print("entou no if")
                //                if frontTouchedNode.name == "RedButton" {
                //                    animate(animatedRetangles: [redRetangleOff])
                //                    print("tocou no vermelho")
                //                }
                //                if frontTouchedNode.name == "BlueButton" {
                //                    animate(animatedRetangles: [blueRetangleOff])
                //                    print("tocou no azul")
                //                }
                //                if frontTouchedNode.name == "YellowButton" {
                //                    animate(animatedRetangles: [yellowRetangleOff])
                //                    print("tocou no amarelo")
                //                }
                //                if frontTouchedNode.name == "GreenButton" {
                //                    animate(animatedRetangles: [greenRetangleOff])
                //                    print("tocou no verde")
                //                }
                playerTurn = false
                animate(animatedRetangles: [frontTouchedNode]) {
                    self.playerTurn = true
                    self.playerSequel.append(frontTouchedNode)

                    if self.playerSequel[self.toque] == self.gameSequel[self.toque] {
                        if self.toque == self.gameSequel.count-1 {
                            self.playerTurn = false
                            self.playGame()
                            self.animateSequel()
                            return
                        }
                        self.toque += 1
                    } else {
                        //                    som de perdeu
                        self.resetPlayerGameSequel()
                        self.resetGame()
                        print("zerou tudo")
                    }
                }

            }
            //        } else {
            //            isUserInteractionEnabled = false
            //            print("o toque é falso")
            //            self.animateSequel()
        }

    }
}
