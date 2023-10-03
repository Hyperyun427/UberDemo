//
//  SearchLocationViewModel.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-17.
//

import Foundation
import MapKit

class SearchLocationViewModel: NSObject, ObservableObject{
    
    //getting input from queryFragment, rework from apple to queryFragment and send to result
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedCoordinate: UberLocation?
    @Published var pickupTime: String?
    @Published var dropoffTime: String?

    
    
    private let searchCompleter = MKLocalSearchCompleter()
    //var selectedLocation: String?
    var queryFragment: String = ""{
        didSet{
            print("Debug: QueryFragment is \(queryFragment)")
            //getting input and set to queryFragment
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init(){
        super.init()
        searchCompleter.delegate = self
        //pass queryFragment to searchCompleter
        searchCompleter.queryFragment = queryFragment
    }
    
    
    var userLocation:CLLocationCoordinate2D?
    
    //helper function to get selected location coordinate
    //transfer selected location to homepage
    func selectLocation(_ location: MKLocalSearchCompletion){
        //call function to get coordinate through location string
        locationSearch(forLocationCompletion: location){
            //location can be optional, so check if it available using error and response
            response, error in
            if let error = error{
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            
            self.selectedCoordinate = UberLocation(title: location.title, coordinate: coordinate)
            
            print("DEBUG: Location Coordinate is \(coordinate)")
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
            self.configPickupAndDropoffTime(with: route.expectedTravelTime)
            completion(route)
            
        }
    }
    
    // calcuate the pickup $$ dropoff time
    func configPickupAndDropoffTime(with expectedTravelTime: Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropoffTime = formatter.string(from: Date() + expectedTravelTime)
        
        
    }
    
    
    
    //transfer location string to coordinate
    //escaping is for escape response
    func locationSearch(forLocationCompletion localSearch: MKLocalSearchCompletion, completion:@escaping MKLocalSearch.CompletionHandler){
        //create request, input title and subtitle, request transfer, finally completionHandler the result
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type: UberRideType) -> Double{
        
        guard let coordinate = selectedCoordinate else{ return 0.0 }
        guard let userLocation = userLocation else { return 0.0 }
        
        let curLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.coordinate.latitude, longitude: coordinate.coordinate.longitude)
        
        let tripDistanceInMeters = curLocation.distance(from: destination)
        
        return type.computePrice(for: tripDistanceInMeters)
    }
}

extension SearchLocationViewModel: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        //set result from completer
        print("Debug: results are \(completer.results)")
        self.results = completer.results
    }
}
