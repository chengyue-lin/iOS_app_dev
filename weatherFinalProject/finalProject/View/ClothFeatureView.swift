//
//  ClothFeatureView.swift
//  finalProject
//
//  Created by 周越 on 3/15/22.
//

import SwiftUI

struct ClothFeatureView: View {
    
    @State var isPresented = false
    var weatherIssues = WeatherIssues(lat:37.76, lon: -122.48)
    
    var l_temp: String {// get the lowest temperature of the day
        weatherIssues.fetchData_Chicago()
        let low_temp = (weatherIssues.allWeatherData[0].main.temp ?? 283.09) - 273.15
        let formattedFloat = String(format: "%.1f", low_temp)
        return "\(formattedFloat)"
    }
    
    var sum_temp: String {// compute the temperature given by clothes
        var value = 0
        for checklistItem in checklistItems {
            if checklistItem.isChecked{
                value = value + checklistItem.addTemp
            }
        }
        return "\(value)"
    }
    // checklist
    @State var checklistItems = [
      ChecklistItem(name: "Thicker down jacket", addTemp: 9),
      ChecklistItem(name: "thin down jacket", addTemp: 6),
      ChecklistItem(name: "thick cotton jacket", isChecked: true,addTemp: 5),
      ChecklistItem(name: "thick wool sweater",addTemp: 4),
      ChecklistItem(name: "cotton vest", isChecked: true, addTemp: 4),
      ChecklistItem(name: "sweater", isChecked: true, addTemp: 3),
      ChecklistItem(name: "jackets", isChecked: true, addTemp: 3),
      ChecklistItem(name: "long johns", isChecked: true, addTemp: 2),
      ChecklistItem(name: "thermal underwear", isChecked: true, addTemp: 1),
    ]
    
    func deleteListItem(whichElement: IndexSet) {
        checklistItems.remove(atOffsets: whichElement)
      }
    
    func moveListItem(whichElement: IndexSet, destination: Int) {
        checklistItems.move(fromOffsets: whichElement, toOffset: destination)
      }
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing: 10) {
                Spacer()
                NavigationLink(destination: clothesView()){
                    Text("3D images").font(.system(size: 17, weight: .heavy, design: .serif))
                        .foregroundColor(Color("Hardly_black"))
                        .frame(width: 100, height: 20, alignment: .center)
                }
                .navigationBarTitle("", displayMode: .inline)
                Text("   ")
            }.background(Color("background_color"))
            List {
                ForEach(checklistItems) { checklistItem in
                    HStack {
                        Text(checklistItem.name)
                        Spacer()
                        Text(checklistItem.isChecked ? "✅" : "🔲")
                    }
                    .onTapGesture {
                        if let matchingIndex =
                            self.checklistItems.firstIndex(where: { $0.id == checklistItem.id }) {
                            self.checklistItems[matchingIndex].isChecked.toggle()
                          }
                    }
                }
                .onDelete(perform: deleteListItem)
                .onMove(perform: moveListItem)
            }
            VStack(spacing:0){
                Text("The minimum temperature in  ").background(Color("background_color"))
                    .frame(width: 390, height: 20, alignment: .center)
                Text("Chicago today is: \(l_temp) °C").background(Color("background_color"))
                    .frame(width: 390, height: 20, alignment: .center)
                Text("You have select \(sum_temp) °C")
                    .background(Color("background_color"))
                    .frame(width: 390, height: 40, alignment: .center)
            }
            .background(Color("background_color"))
            .frame(width: 390, height: 80)

            HStack(spacing: 10) {
                Spacer()
                Button(action: {
                    self.isPresented.toggle()
                }){
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                }.sheet(isPresented: $isPresented, content: {
                    VStack(spacing:10){
                        Spacer()
                            Text(" ")
                            Text("Thicker down jacket is equivalent to 9°C, thin down jacket 6 °C, slightly thicker stretch wadding cotton jacket 5 °C, thick woolen sweater is 4 °C cotton undershirt 4 °C fleece clothing, thin jacket is 3 °C after the cotton shirt is 2 °C thin cotton sweater is 1 °C, dressing formula: ambient temperature + clothing corresponding temperature = 26, for example: the environmental temperature is 22 °C, wear a short-sleeved plus a thin jacket: 22 + 1 + 3 = 26.").foregroundColor(.white)
                                .frame(width: 250, height: 400, alignment: .center)
                            
                            Text("The lowest temperature of the day plus the control temperature of all the clothes gives 26 degrees, so that the ideal temperature for your body can be reached by wearing this.").foregroundColor(.white)
                                .frame(width: 250, height: 150, alignment: .center)
                            Spacer()
                        }
                        .frame(minWidth: 0, idealWidth:100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                        .background(Color.secondary)
            })
                Text("   ")
            }.background(Color("background_color"))
        }
    }
}

struct ClothFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        ClothFeatureView()
    }
}

struct ChecklistItem: Hashable,Identifiable{
    var id = UUID()
    var name: String
    var isChecked: Bool = false
    var addTemp: Int
}

