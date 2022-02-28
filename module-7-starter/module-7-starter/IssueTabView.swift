//
//  IssueTabView.swift
//  module-7-starter
//
//  Created by Ian on 2022/2/26.
//

import SwiftUI

struct IssueTabView: View {
    @ObservedObject var githubIssues: GitHubIssues
    init(githubIssues: GitHubIssues, state: String){
        let appear = UINavigationBarAppearance()
        appear.backgroundColor = .orange
        appear.titleTextAttributes = [.foregroundColor: UIColor.white]
        appear.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().compactAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
        self.state = state
        self.githubIssues = githubIssues
    }
    var state: String
    var body: some View {
        NavigationView{
            
            if state == "open"{
                List(githubIssues.openIssues) { item in
                    NavigationLink(destination: IssueDetail(item: item)) {
                    HStack{
                        Image(systemName: "tray.fill")
                            .resizable()
                            .frame(width:30, height:30)
                            .foregroundColor(.blue)
                        VStack {
                            HStack{
                                Text(item.title ?? "😢")
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                Spacer()
                            }
                            HStack{
                                Text("@" + item.user.login )
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Open Issues", displayMode: .large)
                
                
            }
            else{
                List(githubIssues.closedIssues) { item in
                        NavigationLink(destination: IssueDetail(item: item)) {
                    HStack{
                        Image(systemName: "xmark.bin.fill")
                            .resizable()
                            .frame(width:30, height:30)
                            .foregroundColor(.blue)
                        VStack {
                            HStack{
                                Text(item.title ?? "😢")
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                Spacer()
                            }
                            HStack{
                                Text("@" + item.user.login )
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                }
                            }
                        
                        }
                        
                    }
                }
                .navigationBarTitle("Closed Issues", displayMode: .large)
                
                }
            }
        }
        
}


struct IssueTabView_Previews: PreviewProvider {
    static var previews: some View {
        IssueTabView(githubIssues: GitHubIssues(), state: "open")
    }
}
