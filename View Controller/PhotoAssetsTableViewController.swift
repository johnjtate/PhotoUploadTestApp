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

    var fetchResult: PHFetchResult<PHAsset>!
    // time period during which photos should be fetched
    var startTime: Date = Date()
    var endTime: Date = Date()
    // local source of truth for the images
    var imageData: [Data] = []
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set start and end times for photo fetches
        startTime = Date(dateString: "10-01-2018")
        endTime = Date()

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
    
    func fetchPhotosInDateRange(startDate: Date, endDate: Date) {
        
        let imageManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        // allows synchronous calls
        requestOptions.isSynchronous = true
        // allows photo stored in iCloud to be fetched
        requestOptions.isNetworkAccessAllowed = true
        
        // fetch the images between the start and end date
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchOptions.predicate = NSPredicate(format: "creationDate > %@ AND creationDate < %@", startDate as CVarArg, endDate as CVarArg)

        // empty out the source of truth
        imageData = []
        
        // fetch the image metadata
        let fetchResult: PHFetchResult<PHAsset>
        fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        // if any fetch results, proceed with the image request
        if fetchResult.count > 0 {
            // perform the image request
            for index in 0..<fetchResult.count {
                
                let asset  = fetchResult.object(at: index)
                // request image data
                imageManager.requestImageData(for: asset, options: requestOptions) { (imageData, string, orientation, info) in
                    
                    if let imageData = imageData {
                        self.imageData += [imageData]
                    }
                    if self.imageData.count == fetchResult.count {
                        print("image data has been fetched")
                    }
                }
            }
            
        }
    }

    // MARK: - IBActions
    @IBAction func fetchAssetsButtonTapped(_ sender: Any) {

        fetchPhotosInDateRange(startDate: startTime, endDate: endTime)
        tableView.reloadData()
    }
}

extension PhotoAssetsTableViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // change notifications may originate from a background gueue
        // to update the UI, need to return to the main queue
        
        DispatchQueue.main.async {
            // check the allPhotos fetch for changes
            if let changeDetails = changeInstance.changeDetails(for: self.fetchResult) {
                 // update the cached fetch result
                self.fetchResult = changeDetails.fetchResultAfterChanges
            }
        }
    }
}

// MARK: - DateFormatter

extension Date {
    init(dateString: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM-dd-yyyy"
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval: 0, since: d)
    }
}
