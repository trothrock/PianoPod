//
//  PianoKeyView.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 5/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

extension CGFloat {
    static let pianoKeyAspectRatio: CGFloat = 0.14
}

struct PianoKeyView: View {
    
    @EnvironmentObject var environment: PianoPodEnvironment
    var note: Note
    var color: Color
    var naturalKeyWidth: CGFloat
    
    var body: some View {
        let strokeColor: Color = color != .black ? .black : .white
        
        return Button(action: {
            environment.audioManager.play(note)
        }, label: {
            PianoKeyShape(isAccidental: isAccidental,
                          radius: radius)
                .foregroundColor(color)
                .overlay(
                    PianoKeyShape(isAccidental: isAccidental,
                                  radius: radius)
                        .stroke(strokeColor, lineWidth: 0.5)
                )
        })
        .frame(width: isAccidental ? accidentalKeySize.width : naturalKeySize.width,
               height: isAccidental ? accidentalKeySize.height : naturalKeySize.height)
        .buttonStyle(PianoKeyButtonStyle(isAccidental: isAccidental))
    }
    
    // MARK: - Private
        
    private var naturalKeySize: CGSize {
        return CGSize(width: naturalKeyWidth, height: naturalKeyWidth / CGFloat.pianoKeyAspectRatio)
    }
    
    private var accidentalKeySize: CGSize {
        let width = naturalKeyWidth * 0.6
        return CGSize(width: width, height: width / CGFloat.pianoKeyAspectRatio)
    }
    
    private var radius: CGFloat {
        let divisor: CGFloat = isAccidental ? 9.0 : 7.0
        return naturalKeyWidth / divisor
    }
    
    private var isAccidental: Bool {
        let accidentals: [Pitch] = [.cSharp, .dSharp, .fSharp, .gSharp, .aSharp]
        return accidentals.contains(note.pitch)
    }
    
    private struct PianoKeyButtonStyle: ButtonStyle {
        var isAccidental: Bool
        
        private var verticalTranslation: CGFloat {
            return isAccidental ? 1.0 : 1.005
        }
        
        private var horizontalTranslation: CGFloat {
            return isAccidental ? 0.9 : 0.94
        }
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .scaleEffect(x: configuration.isPressed ? horizontalTranslation : 1.0,
                             y: configuration.isPressed ? verticalTranslation : 1.0,
                             anchor: .top)
        }
    }
    
    private struct PianoKeyShape: Shape {
        var isAccidental: Bool
        var radius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

}

struct PianoKeyView_Previews: PreviewProvider {
    static var previews: some View {
        PianoKeyView(note: Note(pitch: .c, octave: 0),
                     color: .white,
                     naturalKeyWidth: 100)
    }
}
