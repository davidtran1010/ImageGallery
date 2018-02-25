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
        let urlString = imageURL.absoluteString
        print(urlString)
        if urlString.contains("http"){
            imageView.kf.setImage(with: imageURL)
        }else{
            imageView.image = UIImage(contentsOfFile: urlString)
        }
        
    }
}
