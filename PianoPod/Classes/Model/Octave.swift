//
//  Octave.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 5/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct Octave {
    
    var octaveIndex: Int
    
    var naturalNotes: [Note] {
        return noteArray(for: [.c, .d, .e, .f, .g, .a, .b])
    }
    
    var lowerAccidentals: [Note] {
        return noteArray(for: [.cSharp, .dSharp])
    }
    
    var upperAccidentals: [Note] {
        return noteArray(for: [.fSharp, .gSharp, .aSharp])
    }
    
    private func noteArray(for pitches: [Pitch]) -> [Note] {
        return pitches.map { Note(pitch: $0, octave: octaveIndex) }
    }
}
