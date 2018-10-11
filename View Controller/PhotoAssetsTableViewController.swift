//
//  PhotoAssetsTableViewController.swift
//  PhotoUploadTestApp
//
//  Created by John Tate on 10/10/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit
import Photos

class PhotoAssetsTableViewController: UITableViewController {

    // MARK: - Properties

    var allPhotos: PHFetchResult<PHAsset>!
    // time period during which photos should be fetched
    var startTime: Date = Date()
    var endTime: Date = Date()
    
    // MARK: DateFormatter
    
    func dateFromString(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        let date = dateFormatter.date(from: dateString)
        guard let dateToReturn = date else { return nil }
        return dateToReturn
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startTime = dateFromString(dateString: "01-10-2018") ?? Date()
        // create a PHFetchResult object for all photos
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending:    true)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        
        // register a change observer for the photo library (adopting the PHPhotoLibraryChangeObserver protocol in the extension)
        PHPhotoLibrary.shared().register(self)
    }

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PhotoController.shared.photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoAssetCell", for: indexPath)

        let photo = PhotoController.shared.photos[indexPath.row]
        cell.textLabel?.text = photo.identifier
        cell.detailTextLabel?.text = photo.dateCreatedAsString
        return cell
    }
    
    // MARK: - Fetch Function
    
    func fetchAllPhotoAssets(from startDate: Date, to endDate: Date) {
        
        // create NSPredicate for options to fetch only within the specified time period
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let predicate = NSPredicate(
            format: "mediaType == %d",
            PHAssetMediaType.image.rawValue)
        options.predicate = predicate
        
        let result = PHAsset.fetchAssets(with: .image, options: options)
        for index in 0..<result.count {
            let asset = result[index]
            PhotoController.shared.addPhotoFromLibrary(identifier: asset.localIdentifier, dateCreated: asset.creationDate)
            print(asset.localIdentifier)
            print("\(String(describing: asset.creationDate))")
        }
    }

    // MARK: - IBActions
    @IBAction func fetchAssetsButtonTapped(_ sender: Any) {

        fetchAllPhotoAssets(from: startTime, to: endTime)
        tableView.reloadData()
    }
}

extension Date {
    init?(dateString: String) {
        let formatter = DateFormatter()
        guard let date = formatter.date(from: dateString) else { return nil }
        self = date
    }
}

extension PhotoAssetsTableViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // change notifications may originate from a background gueue
        // to update the UI, need to return to the main queue
        
        DispatchQueue.main.async {
            // check the allPhotos fetch for changes
            if let changeDetails = changeInstance.changeDetails(for: self.allPhotos) {
                 // update the cached fetch result
                self.allPhotos = changeDetails.fetchResultAfterChanges
            }
        }
    }
}
