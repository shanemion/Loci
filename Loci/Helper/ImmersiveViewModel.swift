
import RealityKit
import SwiftUI
import RealityKitContent

@MainActor class ImmersiveViewModel: ObservableObject {
    var initialMap: Entity?
    var camEntity: AnchorEntity = {
        let camPov = AnchorEntity()
        camPov.position = [0, 0, 0]
        return camPov
    }()
    
    func setupTapGesture(for hoop: Entity) {
        // Add a collision component to the hoop if it doesn't already have one
//        if hoop.components[CollisionComponent.self] == nil {
            let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(width: 0.5 / 9, height: 0.2 / 9, depth: 0.5/9)])
            hoop.components.set(collisionComponent)
            hoop.components.set(InputTargetComponent())
            print("Added collision and input target components to hoop: \(hoop.name)")
        }
//    }
    
    var hoopTapGesture: some Gesture {
        SpatialTapGesture()
            .targetedToAnyEntity()
            .onEnded { [weak self] value in
                guard let self = self, let initialMap = self.initialMap else {
                    print("Self or initialMap is nil, exiting closure")
                    return
                }
                print("Tapped on entity: \(value.entity.name)")
                self.moveEntitiesRelativeToHoop(hoop: value.entity, in: initialMap)
            }
    }
    
    private func moveEntitiesRelativeToHoop(hoop: Entity, in map: Entity) {
        let hoopPosition = hoop.position(relativeTo: nil)
//        let offset = SIMD3<Float>(-hoopPosition.x, -hoopPosition.y, -hoopPosition.z)
        let offset = SIMD3<Float>(-hoopPosition.x / 9, 0, -hoopPosition.z / 9)

        print("Moving entities by offset: \(offset)")
        
        for child in map.children {
            let currentPosition = child.position(relativeTo: nil)
            let newPosition = currentPosition + offset
            child.setPosition(newPosition, relativeTo: nil)
            // buggy move line
//            child.move(to: Transform(translation: newPosition), relativeTo: map, duration: 1.0)

            print("Moved entity \(child.name) to new position: \(newPosition)")
        }
        
        let mapCurrentPosition = map.position(relativeTo: nil)
        let mapNewPosition = mapCurrentPosition + offset
        map.setPosition(mapNewPosition, relativeTo: nil)
//        map.move(to: Transform(translation: mapNewPosition), relativeTo: camEntity, duration: 1.0)
        print("Moved map to new position: \(mapNewPosition)")
    }
}