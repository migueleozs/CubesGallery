//
//  GalleryApp.swift
//  Gallery
//
//  Created by Miguel Zamudio on 06/01/2025.
//

import SwiftUI

@main
struct GalleryApp: App {

    
    @State private var selectedImmersionStyle: ImmersionStyle = .progressive
    //@State private var appModel = AppModel()
    
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                //.environment(appModel)
        }
        
        WindowGroup(id: "CubeWindow") {
            CubeModel3DView()
        }
        .defaultSize(width: 500, height: 500)
        
        WindowGroup(id: "CubeVolume") {
            CubeRealityView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 0.5, depth: 0.5, in: .meters)
        
        ImmersiveSpace(id: "CubeImmersive") {
            CubeImmersiveView()
        }
        .immersionStyle(selection: $selectedImmersionStyle,
                        in: .mixed, .progressive, .full)
        
        /*
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
         */
        
     }
}
