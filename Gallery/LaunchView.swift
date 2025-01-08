//
//  LaunchView.swift
//  Gallery
//
//  Created by Miguel Zamudio on 06/01/2025.
//

import SwiftUI


struct LaunchView: View {
    
    @State private var isWindowOpen: Bool = false
    @State private var isVolumeOpen: Bool = false
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State private var isImmersiveSpaceOpen: Bool = false
    
    var body: some View {
        Button(isWindowOpen ? "Close Cube Window" : "Open Cube Window") {
            if isWindowOpen {
                dismissWindow(id: "CubeWindow")
                isWindowOpen = false
            } else {
                openWindow(id: "CubeWindow")
                isWindowOpen = true
            }
        }
        
        Button(isVolumeOpen ? "Close Cube Volume" : "Open Cube Volume") {
            if isVolumeOpen {
                dismissWindow(id: "CubeVolume")
                isVolumeOpen = false
            } else {
                openWindow(id: "CubeVolume")
                isVolumeOpen = true
            }
        }
        
        Button(isImmersiveSpaceOpen ? "Close Cube Immersion" : "Open Cube Immersion") {
            Task {
                if isImmersiveSpaceOpen {
                    await dismissImmersiveSpace()
                    isImmersiveSpaceOpen = false
                } else {
                    let result = await openImmersiveSpace(id: "CubeImmersive")
                    switch result {
                    case .opened:
                        isImmersiveSpaceOpen = true
                    case .userCancelled, .error:
                        isImmersiveSpaceOpen = false
                    @unknown default:
                        isImmersiveSpaceOpen = false
                    }
                }
            }
        }
        
        
    }
}

#Preview (windowStyle: .automatic){
    LaunchView()
}
