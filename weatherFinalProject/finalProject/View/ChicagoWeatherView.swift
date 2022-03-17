//
//  ChicagoWeatherView.swift
//  finalProject
//
//  Created by 周越 on 3/15/22.
//

import SwiftUI

struct ChicagoWeatherView: View {
    var weatherIssues: WeatherIssues
    //display current date
    var currentDateString: String{
        weatherIssues.fetchData_Chicago()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy" // OR "dd-MM-yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        return currentDateString
    }
    
    
    var body: some View {
        VStack(spacing:15) {
            HStack(alignment: .center){
                Text(" ")
                Text(" ")
                
                Spacer()
                Text("C h i c a g o")
                    .frame(alignment: .center)
                    .font(.system(size: 25, weight: .heavy, design: .serif))
                    .foregroundColor(Color("Hardly_black"))
                Text("   ")
                Text("   ")
                Spacer()
            }
            .frame(width: 390, height: 30)
            Text(currentDateString)
                .font(.system(size: 20, weight: .heavy, design: .serif))
            .foregroundColor(Color("Gray_Blue"))
            .frame(width: UIScreen.main.bounds.width, height: 25, alignment: .center)
            Image("chicago_skyline")
                .resizable()
                .opacity(0.5)
                .frame(width: 390, height: 250)
                .clipShape(Circle())
            HStack(alignment: .center,spacing: 0){
                VStack {
                    Text("Chicago’s unpredictable weather is often cold & almost certainly windy. ").font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(Color("Hardly_black"))
                        .frame(width: UIScreen.main.bounds.width/1.2, height: 50, alignment: .center)
                    Text("Although it’s known as the “windy city” because of politics, Lake Michigan often brings strong, frigid gusts from the north. ").font(.system(size: 17, weight: .bold, design: .serif))
                        .foregroundColor(Color("Hardly_black"))
                        .frame(width: UIScreen.main.bounds.width/1.2, height: 100, alignment: .center)
                    Text("So, don’t be fooled by the temperature on your phone. Consider the wind chill, and dress warmly! ").font(.system(size: 17, weight: .bold, design: .serif))
                        .foregroundColor(Color("Gray_Blue"))
                        .frame(width: UIScreen.main.bounds.width/1.2, height: 100, alignment: .center)
                }
            }.frame(width: UIScreen.main.bounds.width, height: 300)
            Spacer()
        }
    }
}

struct ChicagoWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ChicagoWeatherView(weatherIssues: WeatherIssues(lat:37.76, lon: -122.48))
    }
}
