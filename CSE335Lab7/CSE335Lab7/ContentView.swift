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
    let magnitude: Double
    let lat:Double
}

struct displayEarthquake : Identifiable
{
    var id = UUID()
    var datetime:String
    var magnitude:String
    
}

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    
    @State var displayEarthquakes:[displayEarthquake]
    
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
    @State var lon:Double
    @State var lat:Double
    
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
                    displayEarthquakes.removeAll()
                    getJsonData(longitude: lon, latitude: lat)
                }label: {
                    Text("Get earthquake info")
                }
                
                
                List {
                    ForEach(displayEarthquakes) {
                        datum in VStack(){
                            HStack {
                                Text(datum.datetime)
                                Text(datum.magnitude)
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    func getJsonData(longitude: Double, latitude: Double) {
        
        var long = (Double(round(100 * longitude) / 100))
        if (long < 0)
        {
            long = long * (-1.0)
        }
        
        var lati = (Double(round(100 * latitude) / 100))
        
        if (lati < 0)
        {
            lati = lati * (-1.0)
        }
        
        
        var north = lati + 10.0
        var south = lati - 10.0
        var east = long - 10.0
        var west = long + 10.0
        
        north = Double(round(100 * north) / 100)
        south = Double(round(100 * south) / 100)
        east = Double(round(100 * east) / 100)
        west = Double(round(100 * west) / 100)
        
        //lon = Double(round(100 * lon) / 100)
        //lat = Double(round(100 * lat) / 100)
        
        
        
        let urlAsString = "http://api.geonames.org/earthquakesJSON?north=" + String(north) + "&south=" + String(south) + "&east=" + String(east) + "&west=" + String(west) + "&username=arjdad"
        print(urlAsString)
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared

        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            var count = 0;
            
            do {
                let decodedData = try JSONDecoder().decode(earthquakeData.self, from: data!)
                
                for earth in decodedData.earthquakes {
                    let currDatetime = earth.datetime
                    let currMagnitude = earth.magnitude
                    displayEarthquakes.append(displayEarthquake(datetime: currDatetime, magnitude: currMagnitude))

                }
                
                //let currDatetime = decodedData.earthquakes[count].datetime;
                //let currMagnitude = String(decodedData.earthquakes[count].magnitude)
                

                
                
                //displayEarthquakes = decodedData.earthquakes;
                
                //print(decodedData.earthquakes[0].src)
                
               // location = decodedData.earthQuakeData[0].placeName
                //longitute = String(decodedData.postalcodes[0].lng)
                //latitude = String(decodedData.postalcodes[0].lat)
                
            } catch {
                print("error: \(error)")
            }
        })
        jsonQuery.resume()
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
                lon = coords.longitude
                
                
                lat = coords.latitude
                
                
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
