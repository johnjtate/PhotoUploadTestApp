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
    
    var identifier: String
    var dateCreated: Date
    var thumbnailImage: Data?
    var photoImage: Data?
    
    var dateCreatedAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: dateCreated)
    }
    
    init(identifier: String, dateCreated: Date = Date(), thumbnailImage: Data?, photoImage: Data?) {
        
        self.identifier = identifier
        self.dateCreated = dateCreated
        self.thumbnailImage = thumbnailImage
        self.photoImage = photoImage
    }
}

