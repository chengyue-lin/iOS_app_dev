//
//  WeatherView.swift
//  finalProject
//
//  Created by 周越 on 3/14/22.
//

import SwiftUI

struct WeatherView: View {
    var weatherIssues: WeatherIssues
    @ObservedObject var locationManager2 = LocationManager()
    var userLatitude: Double {
        return locationManager2.lastLocation?.coordinate.latitude ?? 0
    }
    var userLongitude: Double {
        return locationManager2.lastLocation?.coordinate.longitude ?? 0
    }
    
    enum Tab {
        case chicago
        case list
    }
    // display the current date
    var currentDateString: String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy" // OR "dd-MM-yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        return currentDateString
    }
    
    var body: some View {
        TabView{
            ChicagoWeatherView(weatherIssues: weatherIssues)
                .tabItem {
                    Label("Chicago", systemImage: "star")
                }
                //.tag(Tab.chicago)
            WeatherListView(weatherIssues: WeatherIssues2(lat:Float(userLatitude), lon:Float(userLongitude)))
                .tabItem {
                Label("List", systemImage: "list.bullet")
            }
            //.tag(Tab.list)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherIssues: WeatherIssues(lat:37.76, lon: -122.48))
    }
}
