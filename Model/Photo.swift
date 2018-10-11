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
    var photoImageData: Data?
    
    var dateCreatedAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: dateCreated)
    }
    
    init(identifier: String, dateCreated: Date = Date(), photoImageData: Data?) {
        
        self.identifier = identifier
        self.dateCreated = dateCreated
        self.photoImageData = photoImageData
    }
}

