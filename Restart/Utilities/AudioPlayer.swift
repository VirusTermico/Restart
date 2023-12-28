//
//  AudioPlayer.swift
//  Restart
//
//  Created by Mateus Benilson Martins Fernandes on 01/01/24.
//

import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(sound: String,type: String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        
        do {
           audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch  {
            print("Could not  play the sound")
        }
    }
    
}


