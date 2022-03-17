//
//  WeatherListView.swift
//  finalProject
//
//  Created by 周越 on 3/15/22.
//

import SwiftUI

struct WeatherListView: View {
    @ObservedObject var weatherIssues: WeatherIssues2
    @State private var showingAddPlacesView = false
    @State private var showDetailWeather = false
    @ObservedObject var citys = Citys()
    var city: [String] {// store all city names added into list
        return weatherIssues.cityName
    }
    var weatherdata: [WeatherIssue]{
        // store the weather data for all of city
        return weatherIssues.allWeatherData
    }
    var body: some View {
        
        List{
            HStack{
                Spacer()
                // press button go to the AddPlacesView
                NavigationLink(destination: AddPlacesView(weatherIssues: weatherIssues, citys: citys), isActive: self.$showingAddPlacesView){EmptyView()}
                Button(action: {showingAddPlacesView = true}){
                        Image(systemName: "plus.magnifyingglass")
                            .resizable()
                            .foregroundColor(.orange)
                            .frame(width: 25, height: 25)
                    }
            }
            // display all city name added in the list
                ForEach(0...city.count-1, id: \.self) { count in
                    HStack {
                        Image("\(count % 10)").frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .opacity(0.7)
                        //click the text go to the DetailWeather view
                        NavigationLink{ DetailWeather(weatherIssues: weatherIssues, city: city[count], count:count)} label: {
                            Text(city[count])
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                    }
                }
        }.navigationBarTitle(Text("Weather"), displayMode: .inline)
            
        }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView(weatherIssues: WeatherIssues2(lat:37.76, lon: -122.48))
    }
}
