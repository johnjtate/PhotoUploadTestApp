//
//  PhotoGridCollectionViewCell.swift
//  PhotoUploadTestApp
//
//  Created by John Tate on 10/11/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class PhotoGridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    // landing pad for segue and didSet
    var photo: Photo? {
        didSet {
            guard let photo = photo, let imageData = photo.photoImageData else { return }
            thumbnailImageView.image = UIImage(data: imageData)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    
}
