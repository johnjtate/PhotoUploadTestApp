//
//  PhotoDetailViewController.swift
//  PhotoUploadTestApp
//
//  Created by John Tate on 10/11/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    // MARK: - Properties
    var photo: Photo? {
        didSet {
            if isViewLoaded { updateView() }
        }
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var creationDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        guard let photo = photo else { return }
        self.photoImageView.image = UIImage(data: photo.photoImageData!)
        identifierTextField.text = photo.identifier
        creationDateTextField.text = photo.dateCreatedAsString
    }
}
