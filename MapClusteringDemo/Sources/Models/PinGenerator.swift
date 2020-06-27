
import KSGeometryPackage
import KSPinClusterManagerPackage

class PinGenerator {
    
    func makeUKMap(numberOfPins: Int) -> MapModel {
        var pins = [KSPin]()
        let ukBounds = Geography.ukBounds
        let worldBounds = Geography.worldBounds
        for i in 0 ..< numberOfPins {
            let point = KSPoint(x: Float.random(in: ukBounds.origin.x...ukBounds.origin.x+ukBounds.size.width),
                              y: Float.random(in: ukBounds.origin.y...ukBounds.origin.y+ukBounds.size.height))
            pins.append(KSPin(id: String(i), point: point))
        }
        let map = MapModel(title: "UK pins", bounds: worldBounds, pins: pins)
        return map
    }
    
}
