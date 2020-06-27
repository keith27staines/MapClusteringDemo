
import KSQuadTreePackage
import KSGeometryPackage
import KSPinClusterManagerPackage

class Map {
    
    let clusterManager: ClusterManager
    
    var title: String
    let bounds: KSRect
    
    var clusters = [KSCluster]()
    
    var previousMagnification: Float = 0
    var magnification: Float = 1 {
        didSet {
            previousMagnification = oldValue
        }
    }
    
    var catchementSize: KSSize {
        let side = Geography.ukBounds.size.width / Float(3*magnification)
        return KSSize(width: side, height: side)
    }
    
    init(title: String, bounds: KSRect, pins: [KSPin]) {
        self.title = title
        self.bounds = bounds
        self.clusterManager = ClusterManager(bounds: bounds)
        clusterManager.insert(pins)
    }
    
    func rebuildClusters(in rect: KSRect) {
        clusterManager.rebuildClusters(catchementSize: catchementSize, in: rect)
        clusters = clusterManager.getClusters()
    }
    
}


