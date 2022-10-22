//
//  Note.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 4/20/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

enum Pitch: String {
    case c, cSharp, d, dSharp, e, f, fSharp, g, gSharp, a, aSharp, b
}

struct Note {
    
    var pitch: Pitch
    var octave: Int
    
    var id: String {
        return "\(pitch.rawValue)_\(octave)"
    }

}
