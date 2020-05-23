//
//  PianoView.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 4/20/20.
//

import SwiftUI

struct PianoView: View {
    
    var octave: Int
    var naturalKeyColor: Color
    var accidentalKeyColor: Color
    var backgroundColor: Color
    
    @State private var isPresentingOptions = false
    
    private var naturalNotes: [Note] {
        let pitches: [Pitch] = [.c, .d, .e, .f, .g, .a, .b]
        return pitches.map { Note(pitch: $0, octave: octave) }
    }
    
    private var lowerAccidentals: [Note] {
        let pitches: [Pitch] = [.cSharp, .dSharp]
        return pitches.map { Note(pitch: $0, octave: octave) }
    }
    
    private var upperAccidentals: [Note] {
        let pitches: [Pitch] = [.fSharp, .gSharp, .aSharp]
        return pitches.map { Note(pitch: $0, octave: octave) }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack() {
                    Spacer()
                    Button(action: {
                        print("settings tapped")
                    }, label: {
                        Image(systemName: "gear")
                            .resizable()
                    })
                    .frame(width: 35, height: 35)
                    .foregroundColor(Color.primary)
                    .padding([.top, .bottom, .trailing], 10)
                }
                .background(Color.white)
                
                ZStack(alignment: .top) {
                    HStack(spacing: 0) {
                        ForEach(self.naturalNotes, id: \.id) { note in
                            PianoKeyView(note: note, color: self.naturalKeyColor, parentViewSize: geometry.size)
                        }
                    }
                    HStack(spacing: self.accidentalInterKeySpacing(for: geometry.size)) {
                        Rectangle()
                            .frame(width: self.accidentalEndSpacing(for: geometry.size), height: 0)

                        ForEach(self.lowerAccidentals, id: \.id) { note in
                            PianoKeyView(note: note, color: self.accidentalKeyColor, parentViewSize: geometry.size)
                        }

                        Spacer()

                        ForEach(self.upperAccidentals, id: \.id) { note in
                            PianoKeyView(note: note, color: self.accidentalKeyColor, parentViewSize: geometry.size)

                        }

                        Rectangle()
                            .frame(width: self.accidentalEndSpacing(for: geometry.size), height: 0)
                    }
                }
            }
            
        }.background(backgroundColor)
    }
    
    private func accidentalInterKeySpacing(for size: CGSize) -> CGFloat {
        return (size.width / 7) / 2
    }
    
    private func accidentalEndSpacing(for size: CGSize) -> CGFloat {
        return (size.width / 7) / 4
    }
    
}

struct PianoKeyView: View {
    
    var note: Note
    var color: Color
    var parentViewSize: CGSize
        
    private var naturalKeySize: CGSize {
        let naturalKeyAspectRatio: CGFloat = 2.2/15.0
        let width = parentViewSize.width / 7
        return CGSize(width: width, height: width / naturalKeyAspectRatio)
    }
    
    private var accidentalKeySize: CGSize {
        let accidentalKeyAspectRatio: CGFloat = 1.1/10.0
        let width = naturalKeySize.width / 2
        return CGSize(width: width, height: width / accidentalKeyAspectRatio)
    }
    
    private var isAccidental: Bool {
        let accidentals: [Pitch] = [.cSharp, .dSharp, .fSharp, .gSharp, .aSharp]
        return accidentals.contains(note.pitch)
    }
    
    var body: some View {
        Button(action: {
            print("Play \(self.note.pitch.rawValue)")
        }, label: {
            self.color
        }).border(Color.black, width: 0.5)
            .frame(maxWidth: isAccidental ? accidentalKeySize.width : naturalKeySize.width, maxHeight: isAccidental ? accidentalKeySize.height : naturalKeySize.height, alignment: .leading)
    }

}

struct PianoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//           PianoView(octave: 0, naturalKeyColor: .white, accidentalKeyColor: .black, backgroundColor: .gray)
//              .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//              .previewDisplayName("iPhone 8")

          PianoView(octave: 0, naturalKeyColor: .yellow, accidentalKeyColor: .pink, backgroundColor: .purple)
              .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
              .previewDisplayName("iPhone 11 Pro Max")
            
//            PianoView(octave: 0, naturalKeyColor: .white, accidentalKeyColor: .black, backgroundColor: .gray)
//                .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
//                .previewDisplayName("iPad Pro (9.7-inch)")
        }
    }
    
    
}
