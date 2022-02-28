//
//  IssueTabView.swift
//  module-7-starter
//
//  Created by Ian on 2022/2/26.
//

import SwiftUI

struct IssueTabView: View {
    @ObservedObject var githubIssues: GitHubIssues
    
    var state: String
    var body: some View {
        NavigationView{
            ZStack {
                    Color.green
                        .ignoresSafeArea()
            if state == "open"{
                //let bar = UINavigationBarAppearance()
                //bar.backgroundColor = .systemGreen
                //Rectangle()
                  //  .frame(height: 0)
                   // .background(Color.white)
                List(githubIssues.openIssues) { item in
                    NavigationLink(destination: IssueDetail(item: item)) {
                    HStack{
                        Image(systemName: "tray.fill")
                            .resizable()
                            .frame(width:30, height:30)
                            .foregroundColor(.red)
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
                Rectangle()
                    .frame(height: 0)
                    .background(Color.white)
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
}

struct IssueTabView_Previews: PreviewProvider {
    static var previews: some View {
        IssueTabView(githubIssues: GitHubIssues(), state: "open")
    }
}
