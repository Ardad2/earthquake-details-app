//
//  ContentView.swift
//  CSE335Lab7
//
//  Created by Arjun Dadhwal on 4/2/23.
//

import CoreLocation
import MapKit
import SwiftUI
//import CoreData

struct ContentView: View {
    
    private static let defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
    @State var location =  CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
    var body: some View {
        NavigationView {
            Text("\(location.longitude)")
        }
    }
    
    /*
    
    func getLocation(from address: String, completion: @escaping (_ location:CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder();
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in guard let placemarks = placemarks,
            
            let location = placemarks.first?.location?.coordinate
            else {
                completion(nil);
                return
            }

                    region.center = location
            markers[0] = Location(name: cityName, coordinate: location);


        }
    } */
    
    
    /*
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()    }
    }
    */
}
