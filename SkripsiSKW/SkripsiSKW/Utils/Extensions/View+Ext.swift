//
//  View+Ext.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 25/12/21.
//

import SwiftUI

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
