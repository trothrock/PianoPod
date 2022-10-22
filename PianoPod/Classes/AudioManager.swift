//
//  AudioManager.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 10/5/20.
//

import Foundation
import AVFoundation

protocol AudioManagerProtocol {
    func play(_ note: Note)
}

class AudioManager: AudioManagerProtocol {
    
    private var audioPlayers = [AVAudioPlayer]()
    
    init() {
        if let url = url(for: Note(pitch: .c, octave: 0)),
            let audioPlayer = try? AVAudioPlayer(contentsOf: url) {
            audioPlayer.prepareToPlay()
            audioPlayers.append(audioPlayer)
        }
    }
    
    func play(_ note: Note) {
        guard let audioPlayer = audioPlayers.first(where: {
            $0.url == url(for: note)
        }) else { return }
        audioPlayer.play()
    }
    
    private func url(for note: Note) -> URL? {
        let frameworkBundle = Bundle(for: PianoPod.self)
        guard let bundleUrl = frameworkBundle.resourceURL?.appendingPathComponent("PianoPod.bundle"),
            let resourceBundle = Bundle(url: bundleUrl),
            let path = resourceBundle.path(forResource: "\(note.id).mp3", ofType: nil) else {
            return nil
        }
        return URL(fileURLWithPath: path)
    }
}
