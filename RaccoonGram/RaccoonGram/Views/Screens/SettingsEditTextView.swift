//
//  SettingsEditTextView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 2.08.2022.
//

import SwiftUI

struct SettingsEditTextView: View {
    
    @State var submissionText: String = ""
    @State var title: String
    @State var description: String
    @State var placeholder: String
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Text(description)
                Spacer()
            }
            
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(colorScheme == .light ? Color.MyTheme.beigeColor : Color.MyTheme.tealColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.none)
            
            Button {
                
            } label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .light ? Color.MyTheme.tealColor : Color.MyTheme.lavenderColor)
                    .cornerRadius(12)
            }
            .accentColor(colorScheme == .light ? Color.MyTheme.lavenderColor : Color.MyTheme.tealColor)

            
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarTitle(title)
        
    }
}

struct SettingsEditTextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SettingsEditTextView(title: "Test Title", description: "This is description", placeholder: "Test placeholder")
                .preferredColorScheme(.light)
        }
    }
}
