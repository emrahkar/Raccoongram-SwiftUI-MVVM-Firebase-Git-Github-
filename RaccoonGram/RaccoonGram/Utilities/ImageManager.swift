//
//  ImageManager.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 12.08.2022.
//

import Foundation
import FirebaseStorage
import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

class ImageManager {
    
    //MARK: Properties
    
    static let instance = ImageManager()
    
    private var REF_STOR = Storage.storage()
    
    //MARK: PUBLIC FUNCTIONS
    //Functions we cll from other places in app
    
    func uploadProfileImage(userID: String, image: UIImage) {
        
        //get the path where we will save the image
        let path = getProfileImagePath(userID: userID)
        
        //save image to path
        uploadImage(path: path, image: image) { (_) in }
   }
    
    func uploadPostImage(postID: String, image: UIImage, handler: @escaping(_ success:Bool) ->()) {
        
        //get the path where we will save the image
        
        let path = getPostImagePath(postID: postID)
        
        //save image to path
        uploadImage(path: path, image: image) { (success) in
            handler(success)
        }
    }
    
    
    func downloadProfileImage(userID: String, handler: @escaping (_ image: UIImage?) ->()) {
        //get the path where the image is saved
        let path = getProfileImagePath(userID: userID)
        
        //download the image
        downloadImage(path: path) { (returnedImage) in
            handler(returnedImage)
        }
        
    }
    
    
    
    //MARK: PRIVATE Functions
    //Functions we call from this file only
    
    private func getProfileImagePath(userID: String) -> StorageReference {
        
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
    }
    
    private func getPostImagePath(postID: String) -> StorageReference {
        let postPath = "posts/\(postID)/1"
        let storagePath = REF_STOR.reference(withPath: postPath)
        return storagePath
    }
    
    private func uploadImage(path: StorageReference, image: UIImage, handler: @escaping(_ success: Bool)-> ()) {
        
        var compression: CGFloat = 1.0 //loops down by 0.05
        let maxFileSize: Int = 240 * 240 // max file size we want to save
        let maxCompression: CGFloat = 0.05 //maximum compression allowed
        
        
        //get image data
        guard var originalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            handler(false)
            return
        }
        
        
        //check max file size
        while (originalData.count > maxFileSize) && (compression > maxCompression) {
            compression -= 0.05
            
            if let compressedData = image.jpegData(compressionQuality: compression) {
                originalData = compressedData
            }
            print(compression)
        }
       
        
        //get image data
        guard let finalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            handler(false)
            return
        }
        
        //get photo metadata
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        //save data to path
        path.putData(finalData, metadata: metaData) { (_, error) in
            if let error = error {
                print("Error uploading image \(error)")
                handler(false)
                return
            } else {
                //sucess
                print("Success uploading the image")
                handler(true)
                return
            }
        }
    }
    
    private func downloadImage(path: StorageReference, handler: @escaping (_ image: UIImage?) ->()) {
        
        if let cachedImage = imageCache.object(forKey: path) {
            print("image found in cache")
            handler(cachedImage)
            return
        } else {
            path.getData(maxSize: 27 * 1024 * 1024) { returnedImageData, error in
                
                if let data = returnedImageData, let image = UIImage(data: data) {
                    //success the getting the data
                    imageCache.setObject(image, forKey: path)
                    handler(image)
                    return
                } else {
                    print("error getting data for image")
                    handler(nil)
                    return
                }
            }
        }
    }
}
