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

struct earthquakeData : Decodable
{
    let earthquakes:[earthquake]
}

struct earthquake : Decodable
{
    let datetime:String
    let depth:Double
    let lng:Double
    let src:String
    let eqid: String
    let magnitude: String
    let lat:Double
}

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    
    private static let defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
   /* @State var location =  CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )*/
    
    @State private var region = MKCoordinateRegion(
        center: defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    @State private var markers = [
        Location(name: "Tempe", coordinate: defaultLocation)
    ]
    
    
    @State var location: CLLocationCoordinate2D?

    
    @State var address:String
    @State var lon:String
    @State var lat:String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Current longitude: \(region.center.longitude)")
                Text("Current latitude: \(region.center.latitude) ")
                
                
                TextField("Enter address", text: $address)
                Button{
                    forwardGeocoding(addressStr: address)
                }label: {
                    Text("Get coordinates")
                }
                
                
                Button{
                    
                }label: {
                    Text("Get earthquake info")
                }
            }
        }
    }
    
    func forwardGeocoding(addressStr: String)
    {
        let geoCoder = CLGeocoder();
        let addressString = addressStr
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
                                            {(placemarks, error) in
            
            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                print(coords.latitude)
                print(coords.longitude)
                
                DispatchQueue.main.async
                    {
                        region.center = coords
                        markers[0].name = placemark.locality!
                        markers[0].coordinate = coords
                    }
            }
        })
        
        
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
