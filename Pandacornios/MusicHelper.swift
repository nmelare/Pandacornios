//
//  MusicHelper.swift
//  Pandacornios
//
//  Created by Tamara Erlij on 29/10/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import Foundation
import AVFoundation

class MusicHelper {
    static let shared = MusicHelper()
    var audioPlayer = AVAudioPlayer()
    
    private init() { }
    
    func setup() {
         do {
            audioPlayer =  try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "entrada", ofType: "mp3")!))
           //  audioPlayer.prepareToPlay()
            audioPlayer.play()

        } catch {
           print (error)
        }
    }
    
    func setupInicialScreen() {
        do {
                   audioPlayer =  try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "cenario", ofType: "mp3")!))
                    audioPlayer.prepareToPlay()
                   audioPlayer.play()

               } catch {
                  print (error)
               }
    }


    func play() {
        audioPlayer.play()
    }

    func stop() {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.prepareToPlay()
    }
}
