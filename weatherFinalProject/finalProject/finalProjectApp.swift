//
//  finalProjectApp.swift
//  finalProject
//
//  Created by 周越 on 3/3/22.
//

import SwiftUI

@main
struct finalProjectApp: App {
    @AppStorage("designer1") var designer1: String = "Yue Zhou"
    @AppStorage("designer2") var designer2: String = "Chengyue Lin"
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}

