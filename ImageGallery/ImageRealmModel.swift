//
//  ImageRealmModel.swift
//  ImageGallery
//
//  Created by DavidTran on 2/24/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class ImageRealmModel:Object{
    dynamic var name:String = ""
    dynamic var path:String = ""
    
    convenience init(name:String, path:String) {
        self.init()
        self.name = name
        self.path = path
    }
}
