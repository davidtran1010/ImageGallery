//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by DavidTran on 2/23/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(imageURL:URL) {
     
        imageView.kf.setImage(with: imageURL)
    }
}
