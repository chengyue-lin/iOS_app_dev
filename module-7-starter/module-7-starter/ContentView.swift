//
//  ContentView.swift
//  module-7-starter
//
//  Created by Andrew Binkowski on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var githubIssues: GitHubIssues
    
    // You need to run in simulator or do a Live Preview
    // for the data to load
    var body: some View {
        TabView{
            IssueTabView(githubIssues: githubIssues, state: "open")
                .tabItem{
                    Label("Open", systemImage: "tray.fill")
                        
                }
            IssueTabView(githubIssues: githubIssues, state: "closed")
                .tabItem{
                    Label("Closed", systemImage: "xmark.bin.fill")
                }
        }
        .accentColor(.red)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(githubIssues: GitHubIssues())
    }
}
