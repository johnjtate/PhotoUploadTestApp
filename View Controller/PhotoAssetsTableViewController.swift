//
//  PhotoAssetsTableViewController.swift
//  PhotoUploadTestApp
//
//  Created by John Tate on 10/10/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class PhotoAssetsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    // MARK: - IBActions
    @IBAction func fetchAssetsButtonTapped(_ sender: Any) {
     
        
    }
}
