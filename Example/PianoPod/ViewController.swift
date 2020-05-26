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
        super.init(coder: aDecoder, rootView: PianoView(backgroundColor: .white, accentColor: .blue, naturalKeyColor: .white, accidentalKeyColor: .black))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

