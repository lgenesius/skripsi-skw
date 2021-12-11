//
//  Screen.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

struct Screen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    
    static var statusBarHeight: CGFloat {
        let viewController = UIApplication.shared.windows.first!.rootViewController
        return viewController!.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}
