//
//  AppDelegate.swift
//  billionthtimethecharm
//
//  Created by Alex Xu on 10/22/23.
//

import UIKit
import Firebase
import FirebaseStorage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        
        return true
    }
    
    // new code begin
    func uploadImageToFirebaseStorage(image: UIImage) {
        // Create a unique name for the image (e.g., using a timestamp)
        let imageName = "\(Date().timeIntervalSince1970).jpg"
        
        // Reference to the Firebase Storage bucket
        let storageRef = Storage.storage().reference().child("images").child(imageName)

        // Convert the UIImage to Data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }

        // Upload the image data to Firebase Storage
        let uploadTask = storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Handle error
                return
            }

            // Metadata contains file metadata such as download URL
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Handle error
                    return
                }

                // Use downloadURL to do whatever you need (e.g., save to a database)
                print("Download URL: \(downloadURL)")
            }
        }

        // You can use uploadTask to track the progress or cancel the upload if needed
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            uploadImageToFirebaseStorage(image: pickedImage)
        }

        // dismiss(animated: true, completion: nil)
    }
    // new code end

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

