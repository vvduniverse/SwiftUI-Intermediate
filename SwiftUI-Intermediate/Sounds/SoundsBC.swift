//
//  SoundsBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 24.03.2022.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case ding
        case softgong
        case gamefailed
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

struct SoundsBC: View {
    var body: some View {
        VStack(spacing: 45) {
            Button("Play sound 1") {
                SoundManager.instance.playSound(sound: .ding)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Play sound 2") {
                SoundManager.instance.playSound(sound: .softgong)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Play sound 3") {
                SoundManager.instance.playSound(sound: .gamefailed)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct SoundsBC_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBC()
    }
}
