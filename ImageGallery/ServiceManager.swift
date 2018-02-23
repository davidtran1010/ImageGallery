//
//  ServiceManager.swift
//  ImageGallery
//
//  Created by DavidTran on 2/23/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import FlickrKit
import PromiseKit

struct APIInfo{
    static let key = "0ba2f415c1ddedc0c64a54f5190a1e20"
    static let secret = "8e1597a0dd1fa64c"
}

class ServiceManager{
    
    static let shared = ServiceManager()
    
    init() {
        FlickrKit.shared().initialize(withAPIKey: APIInfo.key, sharedSecret: APIInfo.secret)
    }
    
     func searchImage(with keyword:String) ->Promise<[URL]> {
        let flickrSearch = FKFlickrPhotosSearch()
        flickrSearch.text = keyword
        var photoURLs = [URL]()
        flickrSearch.per_page = "30"
        return Promise{ fulfill, reject in
            FlickrKit.shared().call(flickrSearch) { (response, error) -> Void in
                if (response != nil) {
                    print(response)
                    // Pull out the photo urls from the results
                    let topPhotos = response!["photos"] as! [String: Any]
                    let photoArray = topPhotos["photo"] as! [[String: Any]]
                    for photoDictionary in photoArray {
                        let photoURL = FlickrKit.shared().photoURL(for: .small240, fromPhotoDictionary: photoDictionary)
                        photoURLs.append(photoURL)
                    }
                    fulfill(photoURLs)
                }else{
                    reject(error!)
                }
            }
        }
    }
}
