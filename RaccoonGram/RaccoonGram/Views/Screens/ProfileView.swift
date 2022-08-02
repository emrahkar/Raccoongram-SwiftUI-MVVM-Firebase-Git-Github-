//
//  ProfileView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 31.07.2022.
//

import SwiftUI

struct ProfileView: View {
    
    var ismyProfile: Bool
    @State var profileDisplayName: String
    var profileUserID: String
    
    var posts = PostArrayObject()
    
    @State var showSettings: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ProfileHeaderView(profileDisplayName: $profileDisplayName)
            Divider()
            ImageGridView(posts: posts)
        }
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    showSettings.toggle()
                                }, label: {
                                    Image(systemName: "line.horizontal.3")
                                })
                                .accentColor(Color.MyTheme.tealColor)
                                .opacity(ismyProfile ? 1.0 : 0.0)
        )
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView(ismyProfile: true, profileDisplayName: "Joe", profileUserID: "")
        }
    }
}
