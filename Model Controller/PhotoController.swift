//
//  PhotoController.swift
//  PhotoUploadTestApp
//
//  Created by John Tate on 10/10/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class PhotoController {
    
    // shared instance
    static let shared = PhotoController()
    // create a singleton
    private init() {
        loadFromPersistentStorage()
    }
    
    // source of truth
    var photos: [Photo] = []
    
    func addPhotoFromLibrary(identifier: String, dateCreated: Date?, photoImageData: Data?) {
        
        let newPhoto = Photo(identifier: identifier, dateCreated: dateCreated ?? Date(), photoImageData: photoImageData)
        photos.append(newPhoto)
        saveToPersistentStorage()
    }
    
    // MARK: Persistence
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "photos.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    private func loadFromPersistentStorage() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let photos = try decoder.decode([Photo].self, from: data)
            self.photos = photos
        } catch let error {
            print("There was an error loading from File Manager: \(error)")
        }
    }
    
    private func saveToPersistentStorage() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(photos)
            try data.write(to: fileURL())
        } catch let error {
            print("There was an error saving from File Manager: \(error)")
        }
    }
}
