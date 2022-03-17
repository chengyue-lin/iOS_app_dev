//
//  clothesView.swift
//  finalProject
//
//  Created by 周越 on 3/7/22.
//

import SwiftUI
import SceneKit

struct clothesView: View {
    // 3D view model list
    @State var models = [
        Model(id: 0, name: "dress", modelName: "10157_WomansBusinessDress_v2-L3.obj", details: "A perfectly-tailored suit conveys power, style and a sense of identity. "),
        Model(id: 1, name: "Down coat", modelName: "10135_DownCoat_v01_L3.obj", details: "The down jacket was created by outdoor adventurer Eddie Bauer in 1936. "),
        Model(id: 2, name: "rain-jacket", modelName: "12979_rain_jacket_ adult_v1_l2.obj", details: "Modern raincoats are often constructed from waterproof fabrics that are breathable."),
        Model(id: 3, name: "suit", modelName: "suit.obj", details: "A suit, lounge suit, or business suit is a set of clothes comprising a suit jacke."),
        Model(id: 4, name: "pant", modelName: "pant.obj", details: "Just grab the pair that literally says what day it is on the waistband."),
        Model(id: 5, name: "shirt", modelName: "shirt.obj", details: "A shirt is a cloth garment for the upper body (from the neck to the waist)."),
        Model(id: 6, name: "AirForce", modelName: "AirForce.usdz", details: "Designed by Bruce Kilgore and introduced in 1982, the Air Force 1 was the first ever basketball shoe to feature Nike Air technology. "),
        Model(id: 7, name: "PegasusTrail", modelName: "PegasusTrail.usdz", details: "The Nike Pegasus Trail 3 has the same comfort you love, with a design that nods to the classic Pegasus look.")
    ]
    @State var index = 0
    
    var body: some View {
        VStack(spacing:5){
            HStack(alignment: .center){
                Text(" ")
                Text(" ")
                Spacer()
                Text("3 D clothing")
                    .frame(alignment: .center)
                    .font(.system(size: 25, weight: .heavy, design: .serif))
                    .foregroundColor(Color("Hardly_black"))
                Text(" ")
                Text(" ")
                Spacer()
            }
            SceneView(scene: SCNScene(named: models[index].modelName), options: [.autoenablesDefaultLighting, .allowsCameraControl])
                .frame(width: 350, height: 350)
                .clipShape(Circle())
            ZStack{
                HStack{
                    Button(action: {
                        withAnimation{
                            if index > 0{
                                index -= 1
                            }
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(Color("Hardly_black"))
                            .opacity(index == 0 ? 0.3: 1)
                    })
                        .disabled(index == 0 ? true: false)
                    Spacer(minLength: 0)
                    Button(action: {
                        withAnimation{
                            if index < models.count{
                                index += 1
                            }
                        }
                    }, label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 35, weight: .bold))
                            .opacity(index == models.count - 1 ? 0.3: 1)
                            .foregroundColor(Color("Hardly_black"))
                    })
                        .disabled(index == models.count - 1 ? true: false)
                }
                Text(models[index].name)
                    .font(.system(size: 30, weight: .heavy, design: .serif))
                    .foregroundColor(Color("Hardly_black"))
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical, 30)
            
            VStack(alignment:.leading, spacing: 15, content: {
                Text("About")
                    .font(.system(size: 25, weight: .heavy, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Hardly_black"))
                Text(models[index].details)
                    .foregroundColor(Color("Hardly_black"))
            })
            .padding(.horizontal)
            
            Spacer(minLength: 0)
            
        }.padding(8)
    }
}

struct clothesView_Previews: PreviewProvider {
    static var previews: some View {
        clothesView()
    }
}


struct Model: Identifiable{
    var id: Int
    var name: String
    var modelName: String
    var details: String
}

