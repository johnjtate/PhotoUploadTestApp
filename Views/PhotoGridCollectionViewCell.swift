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

    // selected indicator for deleting photos using collection view
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.alpha = 0.3
            } else {
                self.transform = CGAffineTransform.identity
                self.backgroundColor = .gray
                self.contentView.alpha = 1.0
            }
        }
    }
    
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
