//
//  ImageViewerViewController.swift
//  ImageGallery
//
//  Created by DavidTran on 2/23/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import SDWebImage

class ImageViewerViewController: UIViewController {
    var imageIndex:Int?
    var image:UIImage?
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func downloadImage(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLayoutSubviews() {
        self.tabBarController?.navigationItem.title = "Viewer"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            if let image = self.image{
                self.imageView.image = image
            }
        }
        
        //DispatchQueue.main.async {
            let url = ServiceManager.shared.fetchImageHighResolution(index: self.imageIndex!)
            print(url)
            
            self.imageView.sd_setImage(with: url, placeholderImage: self.image, options: [.avoidAutoSetImage], completed: { (image, error, cache, url) in
                self.image = image
                self.imageView.image = image
            })
        //}
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
