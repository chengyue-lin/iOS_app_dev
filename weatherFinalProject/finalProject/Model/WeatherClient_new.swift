//
//  WeatherClient.swift
//  finalProject
//
//  Created by 周越 on 3/3/22.
//
import Foundation

class WeatherIssues2: ObservableObject{
    /*
     This API try to get the weather data information for city based on the what latitude and longitude we put into the URL link. The URL link is https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=13dd5cf354a7c0eefbc84328c83db108.
     It contains multiple information like sunrise, sunshine, temperature etc.
     */
//
    @Published var weatherData: WeatherIssue = WeatherIssue(coord:coordInfo(lon:139,lat:35),
                                                            weather:[weatherInfo(id:804,main:"Clouds",description:"overcast clouds",icon:"04d")],base:"stations",main:mainInfo(temp:280.55,feels_like:280.03,temp_min:280.55,temp_max:281.73,pressure:1017,humidity:51),visibility:5679,
                                                            wind:windInfo(speed:1.34,deg:109,gust:3.13),clouds:cloudsInfo(all:100),dt:1646359910,sys:sysInfo(type:2,id:2019346,country:"JP",sunrise:1646341831,sunset:1646383289),timezone:32400,id:1851632,name:"Shuzenji",cod:200)
    @Published var allWeatherData: [WeatherIssue] = [WeatherIssue(
        coord:coordInfo(lon:-87.624,lat:41.87),weather:[weatherInfo(id:804,main:"Clouds",description:"overcast clouds",icon:"04d")],base:"stations",main:mainInfo(temp:273.98,feels_like:273.98,temp_min:272.83,temp_max:274.81,pressure:1020,humidity:66),visibility:10000,wind:windInfo( speed:0.89,deg:287,gust:1.79), clouds:cloudsInfo(all:100), dt:1646693698, sys:sysInfo(type:2,id:2005153,country:"US",sunrise:1646655352, sunset:1646696845), timezone:-21600,id:4887398,name:"Chicago",cod:200)]
    @Published var cityName: [String] = ["Chicago"]
    
    let key = "2408d7127c5013acea500e5732176446"
    
    init(lat: Float, lon: Float) {
        fetchData_Chicago()
        fetchData(lat: lat, lon: lon)
    }
    
    func fetchData(lat: Float, lon: Float){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(key)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                print("nothing")
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let issues = try? decoder.decode(WeatherIssue.self, from: data)
            DispatchQueue.main.async {
                if let issues = issues {
                    self.weatherData = issues
                    self.allWeatherData.append(issues)
                    self.cityName.append(self.weatherData.name ?? "Can't find")
                }
            }
        }
        task.resume()
    }
    
    func fetchData_other(lat: Float, lon: Float){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(key)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                print("nothing")
                return
            }
            print("start.")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let issues = try? decoder.decode(WeatherIssue.self, from: data)
            DispatchQueue.main.async {
                if let issues = issues {
                    self.allWeatherData.append(issues)
                    self.cityName.append(issues.name ?? "Can't find")
                }
            }
        }
        task.resume()
    }
    
    func UpdateData(count: Int, lat: Float, lon: Float){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(key)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                print("nothing")
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let issues = try? decoder.decode(WeatherIssue.self, from: data)

            DispatchQueue.main.async {
                if let issues = issues {
                    self.allWeatherData[count] = issues
                }
            }
        }
        task.resume()
    }
    
    func fetchData_Chicago(){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=41.87&lon=-87.624&appid=\(key)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                print("nothing")
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let issues = try? decoder.decode(WeatherIssue.self, from: data)
            DispatchQueue.main.async {
                if let issues = issues {
                    self.weatherData = issues
                    self.allWeatherData[0] = issues
                }
            }
        }
        task.resume()
    }
    
    func fetchData_hasName(name: String){
        let url_ori = "https://api.openweathermap.org/geo/1.0/direct?q=\(name),US&limit=1&appid=\(key)"
        let url = URL(string: url_ori.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                print("nothing")
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let issues = try? decoder.decode([City_lat].self, from: data)
            DispatchQueue.main.async {
                if let issues = issues {
                    let lat = issues[0].lat
                    let lon = issues[0].lon
                    self.fetchData_other(lat: lat!, lon: lon!)
                }
            }
        }
        task.resume()
    }
}


