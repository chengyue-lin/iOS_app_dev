//
//  DetailWeather.swift
//  finalProject
//
//  Created by Ian on 2022/3/6.
//

import SwiftUI

struct DetailWeather: View {
    var weatherIssues: WeatherIssues2
    var city: String
    var count: Int
    
    var currentDateString: String{// display current date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy" // OR "dd-MM-yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        return currentDateString
    }
    
    var lat:Float{// get the latitude of city
        return weatherIssues.allWeatherData[count].coord.lat!
    }
    
    var lon:Float{// get the longitude of city
        return weatherIssues.allWeatherData[count].coord.lon!
    }
    
    var low_temp: String {// get the lowest temperature of the day
        weatherIssues.UpdateData(count: count, lat: lat, lon: lon)
        let low_temp = (weatherIssues.allWeatherData[count].main.temp ?? 287.09) - 273.15
        let formattedFloat = String(format: "%.1f", low_temp)
        return "\(formattedFloat)"
    }
    
    var high_temp:String {// get the highest temperature of the day
        let high_temp = (weatherIssues.allWeatherData[count].main.temp ?? 287.09) - 273.15
            let formattedFloat = String(format: "%.1f", high_temp)
        return "\(formattedFloat)"
    }
    var sun_rise:String{// convert sunrise time into foramt
        let time = weatherIssues.allWeatherData[count].sys.sunrise ?? 1646341831
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    var sun_set:String{// convert sunset time into format
        let time = weatherIssues.allWeatherData[count].sys.sunset ?? 1646341831
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    
   var body: some View {
        VStack(spacing:15) {
            HStack(alignment: .center){
                Text(" ")
                Text(" ")
                
                Spacer()
                Text("\(city)")
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
            Image("\(count % 10)")
                .resizable()
                .opacity(0.6)
                .frame(width: 390, height: 250)
                .clipShape(Circle())
            HStack(alignment: .center,spacing: 0){
                VStack {
                    Text("Current Temperature").font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(Color("Hardly_black"))
                        .frame(width: UIScreen.main.bounds.width/2, height: 30, alignment: .center)
                    Text("\(low_temp)°").font(.system(size: 35, weight: .bold, design: .serif))
                        .foregroundColor(Color("Hardly_black"))
                    .frame(width: UIScreen.main.bounds.width/2, height: 50, alignment: .center)
                }
            }.frame(width: UIScreen.main.bounds.width, height: 80)
            Text("——————————————————————").fontWeight(.heavy).foregroundColor(Color("Gray_Blue"))
            VStack{
                HStack(alignment: .center){
                    Image("cloud_sun")
                        .resizable()
                        .frame(width: 90, height: 90, alignment: .trailing)
                        .opacity(0.9)
                    Text("\(sun_rise)").font(.system(size: 25, weight: .heavy, design: .serif))
                        .foregroundColor(Color("Hardly_black"))
                        .frame(width: 200, height: 40, alignment: .trailing)
                    
                }.frame(width: UIScreen.main.bounds.width, height: 80)
                HStack(alignment: .center){
                    Image("moon")
                        .resizable()
                        .frame(width: 90, height: 90, alignment: .trailing)
                        .opacity(0.9)
                    Text("\(sun_set)").font(.system(size: 25, weight: .heavy, design: .serif))
                        .foregroundColor(Color("Hardly_black"))
                        .frame(width: 200, height: 40, alignment: .trailing)
                    
                }.frame(width: UIScreen.main.bounds.width, height: 80)
            }
            Spacer()
            Spacer()
        }
        
    }
    
}

struct DetailWeather_Previews: PreviewProvider {
    static var previews: some View {
        DetailWeather(weatherIssues: WeatherIssues2(lat:37.76, lon: -122.48), city: "Chicago", count: 0)
    }
}
