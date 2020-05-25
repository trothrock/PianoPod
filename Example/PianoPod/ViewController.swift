//
//  ViewController.swift
//  PianoPod
//
//  Created by theodore.rothrock@gmail.com on 04/20/2020.
//  Copyright (c) 2020 theodore.rothrock@gmail.com. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIHostingController<PianoView> {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: PianoView(naturalKeyColor: .yellow, accidentalKeyColor: .pink, backgroundColor: .purple, accentColor: .white))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

