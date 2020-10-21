//
//  InstantPanGestureRecognizer.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 16.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class InstantPanGestureRecognizer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) { return }
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
}
