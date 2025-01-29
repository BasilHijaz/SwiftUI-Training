//
//  DispatchQueueExtension.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 19/01/2025.
//

import Cocoa

public extension DispatchQueue {

    // MARK: - Public functions

   class func switchToMainIfNeeded(block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
            return
        }
        DispatchQueue.main.async {
            block()
        }
    }
}
