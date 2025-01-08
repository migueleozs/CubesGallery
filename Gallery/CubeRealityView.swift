//
//  CubeRealityView.swift
//  Gallery
//
//  Created by Miguel Zamudio on 07/01/2025.
//

import SwiftUI
import RealityKit

struct CubeRealityView: View {
    
    @State private var scale: CGFloat = 1.0
    
    
    var body: some View {
        
        RealityView (make: { content, attachments in
            if let cube = try? await ModelEntity(named: "Cube") {
                let firstCube = cube.clone(recursive: false)
                firstCube.position = [0.35, 0, 0]
                firstCube.generateCollisionShapes(recursive: false)
                firstCube.components.set(InputTargetComponent())
                
                let secondCube = cube.clone(recursive: false)
                secondCube.position = [0, 0, 0]
                secondCube.generateCollisionShapes(recursive: false)
                secondCube.components.set(InputTargetComponent())
                
                let thirdCube = cube.clone(recursive: false)
                thirdCube.position = [-0.35, 0, 0]
                thirdCube.generateCollisionShapes(recursive: false)
                thirdCube.components.set(InputTargetComponent())
                
                content.add(firstCube)
                content.add(secondCube)
                content.add(thirdCube)
                
                if let attachment = attachments.entity(for: "ScaleInfo"){
                    attachment.position = [0, -0.1, 0.15]
                    content.add(attachment)
                }
            }
        }, update: { content, attachments in
            for entity in content.entities {
                entity.transform.scale = [Float(scale), Float(scale), Float(scale)]
            }
        }
                     ,attachments: {
            Attachment(id: "ScaleInfo") {
                Text("Scale: \(scale)")
                    .padding()
                    .glassBackgroundEffect()
            }
        })
        .gesture(
            MagnifyGesture(minimumScaleDelta: 0)
                .onChanged { value in
                    scale = min(max(1, value.magnification), 1.5)
                }
                .targetedToAnyEntity()
        )
        
        
    }
}

#Preview(windowStyle: .volumetric) {
    CubeRealityView()
}
