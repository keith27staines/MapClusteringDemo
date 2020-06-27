
import KSGeometryPackage
import UIKit
import MapKit

extension KSRect {
    var cgRect: CGRect { CGRect(origin: origin.cgPoint, size: size.cgSize) }
    var coordinateRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: center.locationCoordinate, span: size.coordinateSpan)
    }
}

extension KSPoint {
    var cgPoint: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: CLLocationDegrees(y), longitude: CLLocationDegrees(x))
    }
}

extension KSSize {
    var cgSize: CGSize { CGSize(width: CGFloat(width), height: CGFloat(height)) }
    var coordinateSpan: MKCoordinateSpan {
        MKCoordinateSpan(latitudeDelta: CLLocationDegrees(width), longitudeDelta: CLLocationDegrees(height))
    }
}

extension MKCoordinateRegion {
    var rect: KSRect {
        return KSRect(center: center.point, size: span.size)
    }
}

extension CLLocationCoordinate2D {
    var point: KSPoint {
        KSPoint(x: Float(longitude), y: Float(latitude))
    }
}

extension MKCoordinateSpan {
    var size: KSSize {
        KSSize(width: Float(latitudeDelta), height: Float(longitudeDelta))
    }
}
