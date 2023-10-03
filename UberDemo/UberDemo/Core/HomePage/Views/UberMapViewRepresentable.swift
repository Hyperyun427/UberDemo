//
//  UberMapViewRepresentable.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-13.
//

import SwiftUI
import MapKit

#if os(iOS)
struct UberMapViewRepresentable: UIViewRepresentable{
  //create map with apple mapView
  let mapView = MKMapView()
  // get user location with detailed accurate, updating frequency and aurthorize access
  let locationManager = LocationManager.shared
  //create a locationViewModel to get the taped location but different instance
  @EnvironmentObject var locationViewModel : SearchLocationViewModel
  // need access to get mapstate using binding
  @Binding var mapState: MapViewState

    
  func makeUIView(context: Context) -> some UIView{
      mapView.delegate = context.coordinator
      mapView.showsUserLocation = true
      mapView.userTrackingMode = .follow
      mapView.isRotateEnabled = false
      
      return mapView
        
  }
    
  func updateUIView(
      _ uiView: Self.UIViewType,
      context: Self.Context
    ) {
        print("mapState get from HomwView in UberMapViewRepresentable is \(mapState)")
        
        switch mapState {
        case .defaultHomePage:
            context.coordinator.clearMapViewAndRecenterRegion()
        case .SearchingForDestination:
            break
        case .DestinationSelected:
            if let coordinate = locationViewModel.selectedCoordinate?.coordinate{
                print("DEBUG: Coordinate is \(coordinate)")
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
                print("DEBUG: Selected Location in UberMapViewRepresentable is \(coordinate)")
            }
            break
        }
        
    }
    
  func makeCoordinator() -> MapCoordinator{
      return MapCoordinator(parent: self)
  }
    

    
}

// access coordinator through mapView
extension UberMapViewRepresentable{
    
    class MapCoordinator: NSObject, MKMapViewDelegate{
        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        // rearrange annotaion and route in the middle of map
        var currentRegion: MKCoordinateRegion?
        
        init(parent: UberMapViewRepresentable){
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center:CLLocationCoordinate2D(
                latitude:userLocation.coordinate.latitude,
                longitude:userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta:0.05))
            
            self.currentRegion = region
            
            //need parent to access data to mapView
            parent.mapView.setRegion(region, animated: true)
        }
        
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let line = MKPolylineRenderer(overlay: overlay)
            line.strokeColor = .systemBlue
            line.lineWidth = 6
            return line
        }
        
        // get the coordinate
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
            
            // remove previous annotaion
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            // create annotaion
            let annotaion = MKPointAnnotation()
            annotaion.coordinate = coordinate
            
            // set annotaion
            self.parent.mapView.addAnnotation(annotaion)
            parent.mapView.selectAnnotation(annotaion, animated: true)
            
            // reset map view according to the annotaion changes
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
            
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D){
            
            parent.mapView.removeOverlays(parent.mapView.overlays)
            guard let userLocationCoordinate = userLocationCoordinate else{ return }
            getDestinationRoute(from: userLocationCoordinate, to: coordinate){ route in
                self.parent.mapView.addOverlay(route.polyline)
                
                //create a view to rearrange the route in DestinationSelected view
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                
                //set the region map into the view
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        // generate route through the coordinate
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destinationLocation: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void){
            
            // create MKDirection Request
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let desPlacemark = MKPlacemark(coordinate: destinationLocation)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: desPlacemark)
            
            // pass to MKDirection
            let directions = MKDirections(request: request)
            
            directions.calculate{ response, error in
                if let error = error{
                    print("DEBUG: Failed to get directions to destination with error \(error.localizedDescription)")
                    return
                }
                
                guard let route = response?.routes.first else{ return }
                completion(route)
                
            }
            
            
        }
        
        func clearMapViewAndRecenterRegion(){
            
            //remove annotation and overlays
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            guard let currentRegion = currentRegion else{ return }
            parent.mapView.setRegion(currentRegion, animated: true)
        }
        
        
        
    }
    
}
#endif
