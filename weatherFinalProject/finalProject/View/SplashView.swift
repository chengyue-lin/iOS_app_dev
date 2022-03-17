//
//  SplashView.swift
//  finalProject
//
//  Created by 周越 on 3/14/22.
//

import SwiftUI
import UIKit

struct SplashView: View {
    // get the user's location
    @ObservedObject var locationManager = LocationManager()
    var userLatitude: Double {
        return locationManager.lastLocation?.coordinate.latitude ?? 0
    }
    var userLongitude: Double {
        return locationManager.lastLocation?.coordinate.longitude ?? 0
    }
    @State var isActive1:Bool = false
    var animation: Animation {
        Animation.linear(duration: 2.5)
        .repeatForever(autoreverses: false)
    }
    @State private var isRotated = true
    
    var body: some View {
        VStack {
            if self.isActive1 {
                ContentView(weatherIssues: WeatherIssues(lat: Float(userLatitude), lon: Float(userLongitude)))
            } else {
                VStack {
                    Text(" ")

                    Button("Skip") {
                        self.isActive1.toggle()
                        }.foregroundColor(Color("Gray_Blue"))
                        .frame(width: 300, height: 100, alignment: .trailing)
                    Text(" ")
                        .frame(width: 200, height: 100, alignment: .trailing)
                    Text("KeepWarmToday")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    VStack(alignment:.leading) {
                        Text("How are you？")
                            .font(Font.body)
                            .foregroundColor(Color("Gray_Blue"))
                            .fontWeight(.heavy)
                        Text("  ")
                        Text("———")
                            .foregroundColor(Color("Gray_Blue"))
                        Text("  ")
                            
                        Text("Hope you're in a good")
                            .font(Font.title)
                            .fontWeight(.bold)
                        Text("mood today!")
                            .font(Font.title)
                            .fontWeight(.bold)
                    }
                    Text(" ")
                    VStack(alignment:.trailing) {
                        HStack{
                            Text(" ")
                            Text(" ")
                            Text("Let's take a look at today's weather and decide what to wear today")
                                .font(.system(size: 15, weight: .medium, design: .serif))
                                .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .foregroundColor(Color("background_gray_blue"))
                                                    .frame(height:100))
                            Image("splash")
                                .resizable()
                                .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
                                .animation(animation)
                                .onAppear {
                                    withAnimation {
                                        self.isRotated = false
                                    }
                                }

                        }.background(Color("background_gray_blue"))
                            .frame(width: 0.9 * UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/5)
                            .cornerRadius(10)
                        Text(" ")
                        Button("By Yue Zhou and Chengyue Lin") {
                                self.isRotated.toggle()
                            }.foregroundColor(Color("Gray_Blue"))
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    Spacer(minLength: 1)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive1 = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

