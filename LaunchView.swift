//
//  LaunchView.swift
//  Gallery
//
//  Created by Miguel Zamudio on 06/01/2025.
//

import SwiftUI


struct LaunchView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @State private var isWindowOpen: Bool = false
    
    
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
    }
}

#Preview (windowStyle: .automatic){
    LaunchView()
}
