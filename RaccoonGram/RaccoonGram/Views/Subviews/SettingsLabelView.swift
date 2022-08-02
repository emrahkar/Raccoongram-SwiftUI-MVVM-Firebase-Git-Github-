//
//  SettingsLabelView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 1.08.2022.
//

import SwiftUI

struct SettingsLabelView: View {
    
    @State var labelText: String
    @State var labelImage: String
    
    var body: some View {
        VStack {
            
            HStack{
                Text(labelText)
                Spacer()
                Image(systemName: labelImage)
            }
            Divider()
                .padding(.vertical, 4)
            
        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "My label", labelImage:"heart")
    }
}
