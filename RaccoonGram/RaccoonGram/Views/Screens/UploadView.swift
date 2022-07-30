//
//  UploadView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 30.07.2022.
//

import SwiftUI

struct UploadView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                Button {
                    
                } label: {
                    Text("Upload Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.lavenderColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.MyTheme.tealColor)
                
                Button {
                    
                } label: {
                    Text("Import Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.tealColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.MyTheme.lavenderColor)

                
            }
            
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 1)
              
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
