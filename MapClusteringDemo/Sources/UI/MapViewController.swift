
import UIKit
import KSGeometryPackage
import KSPinClusterManagerPackage
import MapKit

class MapViewController: UIViewController {
    
    let map = PinGenerator().makeUKMap(numberOfPins: 10000)
    var r: CGFloat { CGFloat(Geography.worldBounds.size.height/23.0) }
    let bounds = Geography.worldBounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        configureViews()
    }
    
    var _originalViewport = KSRect.zero
    var viewport: KSRect { mapview.region.rect }
    
    func reloadClusters() {
        mapview.removeAnnotations(mapview.annotations)
        map.rebuildClusters(in: viewport)
        for cluster in map.clusters {
            let annotation = MKPointAnnotation()
            annotation.title = String(cluster.count)
            annotation.coordinate = cluster.centerPin.point.locationCoordinate
            mapview.addAnnotation(annotation)
        }
    }
    
    lazy var mapview: MKMapView = {
        let mapview = MKMapView()
        mapview.delegate = self
        let uk = Geography.ukBounds
        var region = MKCoordinateRegion(center: uk.center.locationCoordinate,
            span: uk.size.coordinateSpan)
        region = mapview.regionThatFits(region)
        mapview.region = region
        mapview.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: "cluster")
        return mapview
    }()
    
    func configureViews() {
        view.addSubview(mapview)
        mapview.translatesAutoresizingMaskIntoConstraints = false
        mapview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if _originalViewport == KSRect.zero { _originalViewport = viewport }
        let newMagnification = _originalViewport.size.height / viewport.size.height 
        if newMagnification != map.previousMagnification {
            map.magnification = newMagnification
            reloadClusters()
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let view = mapview.dequeueReusableAnnotationView(withIdentifier: "cluster") as? ClusterView else { return ClusterView() }
        view.annotation = annotation
        view.countLabel.text = annotation.title ?? ""
        return view
    }
}

class ClusterView: MKAnnotationView {
    static let image: UIImage = {
        let size = CGSize(width: 40, height: 40)
        let image = UIImage(named: "cluster")!.withRenderingMode(.alwaysTemplate).withTintColor(UIColor.systemBlue)
        let renderer = UIGraphicsImageRenderer(size: size)
        let scaled = renderer.image { _ in
            image.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        }
        return scaled
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "0000"
        label.font = UIFont.systemFont(ofSize: 12)
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.white
        label.sizeToFit()
        label.widthAnchor.constraint(equalToConstant: label.frame.size.width).isActive = true
        label.textColor = UIColor.black
        return label
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = Self.image
        canShowCallout = false
        configureViews()
    }
    
    func configureViews() {
        addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        countLabel.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
