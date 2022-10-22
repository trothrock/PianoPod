//
//  PianoPodEnvironment.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 10/5/20.
//

import Foundation
import SwiftUI

class PianoPodEnvironment: ObservableObject {
    
    var audioManager: AudioManagerProtocol = AudioManager()
}
