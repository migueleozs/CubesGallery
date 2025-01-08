//
//  CubeModel3DView.swift
//  Gallery
//
//  Created by Miguel Zamudio on 06/01/2025.
//

import SwiftUI
import RealityKit

struct CubeModel3DView: View {
    
    @State private var rotationY: Double = 0.0
    
    
    var body: some View {
        //Model3D(named: "Cube")
            //.padding3D(.back, 80)
        
        Model3D(named: "Cube") { model in
            model
                .rotation3DEffect(
                    .degrees(rotationY),
                    axis: (x: 0, y: 1, z: 0)
                )
        } placeholder: {
            ProgressView()
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    rotationY += Double(value.translation.width / 100)
                    rotationY = rotationY.truncatingRemainder(dividingBy: 360)
                }
        )
        .ornament(attachmentAnchor: .scene(.bottom)) {
            Text("Rotation: \(rotationY, specifier: "%.2f")º")
                .padding()
                .glassBackgroundEffect()
        }
    }
    
    
    
}

#Preview {
    CubeModel3DView()
}
