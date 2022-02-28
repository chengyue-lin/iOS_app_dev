//
//  IssueDetail.swift
//  module-7-starter
//
//  Created by Ian on 2022/2/26.
//

import SwiftUI

struct IssueDetail: View {
    var item: GitHubIssue
    var body: some View {
        ScrollView{
            VStack{
                Text( item.title ?? "😢")
                    .font(.largeTitle)
                    .padding()
                HStack{
                    AsyncImage(url: URL(string: item.user.avatarUrl ?? "")!) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.black, lineWidth: 1))
                    Text("User: @" + item.user.login)

                }

                
                HStack{
                    Text("Date: ")
                    Text(formatDate(date: item.createdAt!) ?? "")

                    Image(systemName: item.state == "open" ? "tray.fill" : "xmark.bin.fill")
                        .resizable()
                        .frame(width:30, height:30)
                        .foregroundColor(.blue)
                        
                }


                HStack {
                    Text("Description")
                        .font(.largeTitle)
                    Spacer()
                }
                .padding()
                Text(item.body ?? "😢")
                    .padding()
            }
        }
    }
}

struct IssueDetail_Previews: PreviewProvider {
    static var previews: some View {
        IssueDetail(item: GitHubIssue(title: "HDDS-6376. Docs: Fix classpath for ofs and o3fs", id: 1150070266, createdAt: "2022-02-25T05:49:50Z", body: "## What changes were proposed in this pull request?\r\n\r\nFix classpath for ofs and o3fs in docs.\r\n\r\n## What is the link to the Apache JIRA\r\n\r\nhttps://issues.apache.org/jira/browse/HDDS-6376\r\n\r\n## How was this patch tested?\r\n\r\nNo need\r\n", state: "open", user: GitHubUser(login: "kaijchen", avatarUrl: "https://avatars.githubusercontent.com/u/5821159?v=4")))
    }
}
