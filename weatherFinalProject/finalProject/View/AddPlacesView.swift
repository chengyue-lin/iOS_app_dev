//
//  AddPlacesView.swift
//  finalProject
//
//  Created by Ian on 2022/3/6.
//

import SwiftUI
import MapKit

struct AddPlacesView: View {
    @State private var searchStr = ""
    @Environment(\.presentationMode) var presentationMode
    var weatherIssues: WeatherIssues2
    var citys: Citys
    var body: some View {
        // list all of the city name in the json file
        List{
            //filter result of list based on the search string
            ForEach(searchStr == "" ? citys.allOfCity: citys.allOfCity.filter{$0.contains(searchStr)}, id: \.self){ each in
                Button(action: {
                    weatherIssues.fetchData_hasName(name: each)
                    print("\(each) has been added into the list")
                    AppStoreReviewManager.requestReviewIfAppropriate()
                    // if we press any of city name, it will go back to previous page and add the city name you selected append into the list.
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(each)
                })
                    
            }
            .navigationTitle("Place want to add")
                
        }
        .searchable(text: $searchStr,placement: .navigationBarDrawer(displayMode: .always))
        
        
        
    }
}

struct AddPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddPlacesView(weatherIssues: WeatherIssues2(lat:37.76, lon: -122.48), citys: Citys())
        }
    }
}
