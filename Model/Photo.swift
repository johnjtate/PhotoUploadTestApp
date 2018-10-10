//
//  Photo.swift
//  PhotoUploadTestApp
//
//  Created by John Tate on 10/10/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class Photo {
    
    let identifier: String
    let dateCreated: Date
    
    init(identifier: String, dateCreated: Date = Date()) {
        
        self.identifier = identifier
        self.dateCreated = dateCreated
    }
}

