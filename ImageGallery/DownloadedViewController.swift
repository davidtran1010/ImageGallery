//
//  DownloadedViewController.swift
//  ImageGallery
//
//  Created by DavidTran on 2/24/18.
//  Copyright © 2018 DavidTran. All rights reserved.
//

import UIKit

class DownloadedViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        setupTabbarNavigation()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DownloadedViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DownloadedImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.backgroundColor = UIColor.brown
        //cell.configure(imageURL: imageURLs[indexPath.item])
        return cell
    }
    
    
}
