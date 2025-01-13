//
//  CubeImmersiveView.swift
//  Gallery
//
//  Created by Miguel Zamudio on 07/01/2025.
//
//"Adidas shoe .::RAWscan::. NO TEXTURE" (https://skfb.ly/ptpGC) by Andrea Spognetta (Spogna) is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).

import SwiftUI
import RealityKit

struct CubeImmersiveView: View {
    @State private var rotation: Double = 0

    var body: some View {
        RealityView { content in
            let anchor = AnchorEntity()

            // Cargar los modelos
            //async {
                // Cargar el modelo de la bota
                guard let boot = try? await ModelEntity(named: "Adidas") else {
                    print("Error al cargar el modelo 'Adidas'")
                    return
                }
                
                // Cargar el modelo del cubo
                guard let cube = try? await ModelEntity(named: "Cube") else {
                    print("Error al cargar el modelo 'cube'")
                    return
                }
                
                let numberOfEntities = 8 // Número total de entidades
                for index in 0..<numberOfEntities {
                    let angle = Float(index) * (2 * .pi / Float(numberOfEntities)) // Calcular el ángulo
                    let xPosition = cos(angle)
                    let zPosition = sin(angle)

                    // Elegir el modelo según el índice
                    let entity = (index % 2 == 0) ? boot.clone(recursive: false) : cube.clone(recursive: false)
                    
                    // Configurar la posición y colisiones
                    entity.position = [xPosition, 1.5, zPosition]
                    entity.generateCollisionShapes(recursive: false)
                    entity.components.set(InputTargetComponent())

                    // Agregar la entidad al ancla
                    anchor.addChild(entity)
                }
                
                // Agregar el ancla al contenido
                content.add(anchor)
           // }
        }
        update: { content in
            if let anchor = content.entities.first {
                anchor.transform.rotation = simd_quatf(angle: Float(rotation) * .pi / 180, axis: [0, 1, 0])
                for entity in anchor.children {
                    entity.transform.rotation = simd_quatf(
                        Rotation3D(angle: Angle2D(degrees: rotation), axis: .xyz)
                    )
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    rotation += value.translation.width/100
                }
                .targetedToAnyEntity()
        )
    }
}
#Preview {
    CubeImmersiveView()
}
