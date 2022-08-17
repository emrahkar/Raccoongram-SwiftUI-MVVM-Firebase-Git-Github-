//
//  PostImageView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 31.07.2022.
//

import SwiftUI

struct PostImageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @State var captionText: String = ""
    @Binding var imageSelected: UIImage
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
    
    //Alert
    
    @State var showAlert:Bool = false
    @State var postUploadedSuccessfully: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                }
                .accentColor(.primary)
                
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .cornerRadius(12)
                    .clipped()
                
                TextField("Add you caption here..", text: $captionText)
                    .font(.headline)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .light ? Color.MyTheme.beigeColor : Color.MyTheme.tealColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .autocapitalization(.sentences)
                
                Button {
                    postPicture()
                } label: {
                    Text("Post your Picture!".uppercased())
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(colorScheme == .light ? Color.MyTheme.tealColor : Color.MyTheme.lavenderColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .accentColor(colorScheme == .light ? Color.MyTheme.lavenderColor : Color.MyTheme.tealColor)
            }
            .alert(isPresented: $showAlert) {
                getAlert()
            }
        }
    }
    
    //MARK: FUNCTIONS
    
    func postPicture() {
        print("POST PICTURE TO DATABASE HERE")
        
        guard let userID = currentUserID, let displayName = currentUserDisplayName else {
            print("error getting userID or display name while posting image")
            return
        }
        
        DataService.instance.uploadPost(image: imageSelected, caption: captionText, displayName: displayName, userID: userID) { (success) in
            self.postUploadedSuccessfully = success
            self.showAlert.toggle()
        }
    }
    
    func getAlert() -> Alert {
        
        if postUploadedSuccessfully {
            return Alert(title: Text("sucessfully uploaded post"), message: nil, dismissButton: .default(Text("OK"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        } else {
            return Alert(title: Text("Error poading post"))
        }
    }
}

struct PostImageView_Previews: PreviewProvider {
    
    @State static var image = UIImage(named: "raccoon1")!
    static var previews: some View {
        PostImageView(imageSelected: $image)
            .preferredColorScheme(.dark)
    }
}
