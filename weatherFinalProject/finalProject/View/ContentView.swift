//
//  ContentView.swift
//  finalProject
//
//  Created by 周越 on 3/3/22.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    
    @ObservedObject var weatherIssues: WeatherIssues
    @AppStorage("review.counter") private var reviewCounter = 0
    
    var currentDateString: String{// display the current date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy" // OR "dd-MM-yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        return currentDateString
    }
    
    func showReviewPrompt() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    

    var body: some View {//display the view of main screen
        
        NavigationView {
            VStack {
                Text("").frame(width: 390, height: 25)
                HStack(alignment: .center){
                    Text(" ")
                    Text(" ")
                    
                    Spacer()
                    Text("T o d a y")
                        .frame(alignment: .center)
                        .font(.system(size: 25, weight: .heavy, design: .serif))
                        .foregroundColor(Color("Hardly_black"))
                    Text("   ")
                    Text("   ")
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width, height: 20)
                Text(currentDateString)
                    .font(.system(size: 20, weight: .heavy, design: .serif))
                .foregroundColor(Color("Gray_Blue"))
                .frame(width: UIScreen.main.bounds.width, height: 35, alignment: .center)
                Text(" ").frame(width: UIScreen.main.bounds.width, height: 40, alignment: .center)
                Image("cloud_sun")
                    .resizable()
                    .frame(width: 280, height: 270)
                    .opacity(0.9)
                HStack(alignment: .center,spacing: 0){
                    Text("26°").font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(Color("Hardly_black"))
                        .frame(width: UIScreen.main.bounds.width/2.9, height: 100, alignment: .center)
                    VStack(spacing:0){
                        Text("About 26 degrees Celsius dressing rules:").font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(Color("Hardly_black"))
                            .frame(width: UIScreen.main.bounds.width/1.8, height: 50, alignment: .center)
                        Text("How to keep the ideal temperature for your body ?").font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(Color("Gray_Blue"))
                            .frame(width: UIScreen.main.bounds.width/1.8, height: 50, alignment: .center)
                    }.frame(width: UIScreen.main.bounds.width/1.8, height: 100, alignment: .center)
                }.frame(width: UIScreen.main.bounds.width, height: 110)
                Text("——————————————————————").fontWeight(.heavy).foregroundColor(Color("Gray_Blue"))
                VStack{
                    HStack(alignment: .center){// click text "Weather" go to the WeatherView
                            NavigationLink(destination: WeatherView(weatherIssues: weatherIssues)){
                                Text("  Weather").font(.system(size: 25, weight: .heavy, design: .serif))
                                    .foregroundColor(Color("Hardly_black"))
                                    .frame(width: UIScreen.main.bounds.width/2.5, height: 40, alignment: .center)
                            }.navigationBarHidden(true)
                        Spacer()
                        Image("sunny")
                            .resizable()
                            .frame(width: 90, height: 90, alignment: .trailing)
                            .opacity(0.9)
                        Text(" ").frame(width: 20, height: 90, alignment: .trailing)
                        
                    }.frame(width: UIScreen.main.bounds.width, height: 80)
                    HStack(alignment: .center){// click text "OOTD" go to the ClothFeatureView
                      NavigationLink(destination: ClothFeatureView()){
                           Text("OOTD").font(.system(size: 25, weight: .heavy, design: .serif))
                               .foregroundColor(Color("Hardly_black"))
                                .frame(width: UIScreen.main.bounds.width/2.5, height: 40, alignment: .center)
                      }
                        Spacer()
                        Image("dot")
                            .resizable()
                            .frame(width: 90, height: 90, alignment: .trailing)
                            .opacity(0.8)
                        Text(" ").frame(width: 20, height: 90, alignment: .trailing)
                        
                    }.frame(width: UIScreen.main.bounds.width, height: 80)
                }
                Spacer()
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .navigationBarHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherIssues: WeatherIssues(lat:37.76, lon: -122.48))
    }
}
