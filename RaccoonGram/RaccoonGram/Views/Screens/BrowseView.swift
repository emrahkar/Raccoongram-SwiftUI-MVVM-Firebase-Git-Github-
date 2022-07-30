//
//  BrowseView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 30.07.2022.
//

import SwiftUI

struct BrowseView: View {
    
    var posts = PostArrayObject()
    
    var body: some View {
        ScrollView {
            CarouselView()
            ImageGridView(posts: posts)
        }
        .navigationBarTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            BrowseView()
        }
    }
}
