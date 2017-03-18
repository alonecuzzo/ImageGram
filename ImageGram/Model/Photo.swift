//
//  Photo.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation


/**
 * Backing model for json photo objects.
 */
struct Photo {
    let albumID: Int
    let title: String
    let url: URL
    let thumbnailURL: URL
}


//MARK: ResponseObjectSerializable, ResponseCollectionSerializable
extension Photo: ResponseObjectSerializable, ResponseCollectionSerializable {
    init?(response: HTTPURLResponse, representation: Any) {
        guard let innerRepresentation = representation as? [String: Any],
            let albumID = innerRepresentation["albumId"] as? Int,
            let title =  innerRepresentation["title"] as? String,
            let urlString = innerRepresentation["url"] as? String,
            let convertedURL = URL(string: urlString),
            let thumbnailURLString = innerRepresentation["thumbnailUrl"] as? String,
            let convertedThumbnailURL = URL(string: thumbnailURLString)
            else { return nil }

        self.albumID = albumID
        self.title = title
        self.url = convertedURL
        self.thumbnailURL = convertedThumbnailURL
    }
}
