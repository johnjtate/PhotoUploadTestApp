//
//  Photo.swift
//  PhotoUploadTestApp
//
//  Created by John Tate on 10/10/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import UIKit

class Photo: Codable {
    
    let identifier: String
    let dateCreated: Date
    let thumbnailImage: Data?
    let photoImage: Data?
    
    init(identifier: String, dateCreated: Date = Date(), thumbnailImage: Data?, photoImage: Data?) {
        
        self.identifier = identifier
        self.dateCreated = dateCreated
        self.thumbnailImage = thumbnailImage
        self.photoImage = photoImage
    }
}

