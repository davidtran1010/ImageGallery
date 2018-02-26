//
//  ImageViewerViewController.swift
//  ImageGallery
//
//  Created by DavidTran on 2/23/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import SDWebImage
import Toast_Swift
import RealmSwift

class ImageViewerViewController: UIViewController,UIScrollViewDelegate {
    var imageIndex:Int?
    var image:UIImage?
    var isFetchFullResolution = false
    var notificationToken:NotificationToken?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func downloadImage(_ sender: UIBarButtonItem) {
        
        // Save image to local
        let imageData = UIImagePNGRepresentation(image!)
        let fileManager = FileManager.default
        let convertedDateTime = getCurrentDateTime().replacingOccurrences(of: "/", with: "_")
        let imageName = "image_" + convertedDateTime + ".png"
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        fileManager.createFile(atPath: imagePath, contents: imageData, attributes: nil)
    
        // Save path to realm DB
        let realmModel = ImageRealmModel(name: imageName, path: imagePath)
       
        RealmService.shared.create(realmModel)

         //self.view.makeToast("Finished downloading photo.")
    }
    
    override func viewDidLayoutSubviews() {
        self.tabBarController?.navigationItem.title = "Viewer"
    }
    override func viewWillAppear(_ animated: Bool) {
        let realm = RealmService.shared.realm
        notificationToken = realm.observe { (notification, realm) in
            print("Finished downloading photo.")
            self.view.makeToast("Finished downloading photo.")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        notificationToken?.invalidate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        
        DispatchQueue.main.async {
            if let image = self.image{
                self.imageView.image = image
            }
        }
        
        // Fetch full res image if view image from search view
        if isFetchFullResolution{
            let url = ServiceManager.shared.fetchImageHighResolution(index: self.imageIndex!)
            print(url)
            
            self.imageView.sd_setImage(with: url, placeholderImage: self.image, options: [.avoidAutoSetImage], completed: { (image, error, cache, url) in
                self.image = image
                self.imageView.image = image
            })
        }
        // Hide down icon if view image from downloaded view
        else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem()
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = Int(calendar.component(.second, from: date))
        
        return "\(day)/\(month)/\(year)_\(hours)_\(minutes)_\(seconds)"
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
