//
//  ContentView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 26.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    var currentUserID: String? = nil
    
    var body: some View {
        
        TabView{
            NavigationView{
                FeedView(posts: PostArrayObject(), title: "Feed")
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView {
                BrowseView()
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }
            
            UploadView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            
            ZStack{
                if currentUserID != nil {
                    NavigationView {
                        ProfileView(ismyProfile: true, profileDisplayName: "My Profile", profileUserID: "")
                    }
                } else {
                    SignUpView()
                }
            }
                .tabItem {
                    Image(systemName: "pawprint.fill")
                    Text("Profile")
                }
        }
        .accentColor(Color.MyTheme.tealColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
