//
//  PianoPod.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 4/20/20.
//

import Foundation
import SwiftUI

public class PianoPod {
    
    public static func pianoView(backgroundColor: Color = .white, accentColor: Color = .gray, naturalKeyColor: Color = .white, accidentalKeyColor: Color = .black, visibleOctaves: Int = 1, settingsEnabled: Bool = true) -> PianoView {
        return PianoView(backgroundColor: backgroundColor, accentColor: accentColor, naturalKeyColor: naturalKeyColor, accidentalKeyColor: accidentalKeyColor, visibleOctaves: visibleOctaves, settingsEnabled: settingsEnabled)
    }
}
