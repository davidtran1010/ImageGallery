//
//  DownloadedViewController.swift
//  ImageGallery
//
//  Created by DavidTran on 2/24/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class DownloadedViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    var downloadedImages: Results<ImageRealmModel>!
    var selectedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmService.shared.realm
        downloadedImages = realm.objects(ImageRealmModel.self)
    //    realm.observe { (notification, realm) in
        //    self.imageCollectionView.reloadData()
      //  }
        
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        setupCollectionView()
        setupTabbarNavigation()
        
        // Do any additional setup after loading the view.
    }

    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        imageCollectionView!.collectionViewLayout = layout
    }
    override func viewWillAppear(_ animated: Bool) {
         self.imageCollectionView.reloadData()
        print("Downloaded view show")
        self.tabBarController?.navigationItem.title = "Photo library"
    }

    // Setup tab bar navigation
    func setupTabbarNavigation(){
       // self.tabBarController?.navigationItem.title = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "downloadedImageViewerSegue"{
            let destinationVC = segue.destination as! ImageViewerViewController
            destinationVC.image = selectedImage!
            destinationVC.isFetchFullResolution = false
        }
    }
    

}
extension DownloadedViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: screenSize.screenWidth/3, height: screenSize.screenWidth/3);
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell \(indexPath.item) selected")
        
        //selectedIndex = indexPath.item
        let selectedCell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        selectedImage = selectedCell.imageView.image
        performSegue(withIdentifier: "downloadedImageViewerSegue", sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DownloadedImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.configure(imageURL: URL(string: downloadedImages[indexPath.item].path)!)
        
        return cell
    }
    
    
}
