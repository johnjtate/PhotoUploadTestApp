//
//  PhotoGridCollectionViewController.swift
//  PhotoUploadTestApp
//
//  Created by John Tate on 10/11/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoGridCell"

class PhotoGridCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    fileprivate var selectedPhotos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = true 
        
    // only need to do this if set up collection view cell programmatically
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
  
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return PhotoController.shared.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoGridCollectionViewCell
        
        let photo = PhotoController.shared.photos[indexPath.row]
        cell?.photo = photo
        return cell ?? UICollectionViewCell()
    }
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    // MARK: - IBActions

    @IBAction func deletePhotosButtonTapped(_ sender: Any) {
        
        guard var cellsToDelete = self.collectionView!.indexPathsForSelectedItems, cellsToDelete.count > 0 else { return }
        cellsToDelete.sort()
        for indexPath in cellsToDelete.reversed() {
            PhotoController.shared.photos.remove(at: indexPath.item)
        }
        self.collectionView!.performBatchUpdates({
            self.collectionView!.deleteItems(at: cellsToDelete)
        })
    }
}
