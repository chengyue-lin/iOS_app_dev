//
//  Models.swift
//  finalProject
//
//  Created by 周越 on 3/3/22.
//

import Foundation

struct listInfo: Codable {
    let dt: UInt32?
    let main: mainInfo
    let weather: [weatherInfo]
    let clouds: cloudsInfo
    let wind: windInfo
    let visibility: Int32?
    let sys: sysInfo
    let dt_txt: String?
    
}

struct mainInfo: Codable{
    let temp: Float?
    let feels_like: Float?
    let temp_min: Float?
    let temp_max: Float?
    let pressure: Int32?
    let humidity: Int32?
}

struct weatherInfo: Codable{
    let id: Int32?
    let main: String?
    let description: String?
    let icon: String?
}

struct cloudsInfo: Codable{
    let all: Int32?
}

struct windInfo: Codable{
    let speed: Float?
    let deg: Int32?
    let gust: Float?
}

struct sysInfo: Codable{
    let type: Int32?
    let id: Int32?
    let country: String?
    let sunrise: Int32?
    let sunset: Int32?
}

struct WeatherIssue: Codable, Identifiable{
    let coord: coordInfo
    let weather: [weatherInfo]
    let base: String?
    let main: mainInfo
    let visibility: Int32?
    let wind: windInfo
    let clouds: cloudsInfo
    let dt: Int32?
    let sys: sysInfo
    let timezone: Int32?
    let id: Int32?
    let name: String?
    let cod: Int32?
}

struct cityInfo: Codable{
    let id: Int32
    let name: String?
    let coord: coordInfo
    let country: String?
    let population: Int32
    let timezone: Int32?
    let sunrise: Int32?
    let sunset: Int32?
    
}

struct coordInfo: Codable{
    let lon: Float?
    let lat: Float?
}

let testData = WeatherIssue(coord:coordInfo(lon:139,lat:35),
                            weather:[weatherInfo(id:804,main:"Clouds",description:"overcast clouds",icon:"04d")],base:"stations",main:mainInfo(temp:280.55,feels_like:280.03,temp_min:280.55,temp_max:281.73,pressure:1017,humidity:51),visibility:5679,
                            wind:windInfo(speed:1.34,deg:109,gust:3.13),clouds:cloudsInfo(all:100),dt:1646359910,sys:sysInfo(type:2,id:2019346,country:"JP",sunrise:1646341831,sunset:1646383289),timezone:32400,id:1851632,name:"Shuzenji",cod:200)

let testData2 = [WeatherIssue(coord:coordInfo(lon:139,lat:35),
                              weather:[weatherInfo(id:804,main:"Clouds",description:"overcast clouds",icon:"04d")],base:"stations",main:mainInfo(temp:280.55,feels_like:280.03,temp_min:280.55,temp_max:281.73,pressure:1017,humidity:51),visibility:5679,
                              wind:windInfo(speed:1.34,deg:109,gust:3.13),clouds:cloudsInfo(all:100),dt:1646359910,sys:sysInfo(type:2,id:2019346,country:"JP",sunrise:1646341831,sunset:1646383289),timezone:32400,id:1851632,name:"Shuzenji",cod:200)]
