//
//  RTPermissions.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import Foundation
import Photos

class RTPermissions {
    private init() {}
    
    static func getGalleryPermission(completion: @escaping (_ granted: Bool)->()) {
        let galleryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch galleryAuthorizationStatus {
        case .authorized:
            completion(true)
            break
        case .denied:
            completion(false)
            break
        case .restricted:
            completion(false)
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
            break
        }
    }
    
    static func openAppSettings() {
        DispatchQueue.main.async {
            if let settingsUrl = URL(string:UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.canOpenURL(settingsUrl)
            }
        }
    }
}
