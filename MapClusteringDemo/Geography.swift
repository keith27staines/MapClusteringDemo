
import KSGeometryPackage

struct Geography {
    static let worldBounds = KSRect(
        origin: KSPoint(
            x: -180,
            y: -90),
        size: KSSize(
            width: 360,
            height: 180
        )
    )
    
    static let ukBounds = KSRect(
        origin: KSPoint(
            x: -9,
            y: 50),
        size: KSSize(
            width: 11,
            height: 11)
    )
}
