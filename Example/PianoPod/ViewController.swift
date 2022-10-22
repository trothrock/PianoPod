//
//  ViewController.swift
//  PianoPod
//
//  Created by theodore.rothrock@gmail.com on 04/20/2020.
//  Copyright (c) 2020 theodore.rothrock@gmail.com. All rights reserved.
//

import UIKit
import SwiftUI
import PianoPod

class ViewController: UIHostingController<AnyView> {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: PianoPod.pianoView(visibleOctaves: 2))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

