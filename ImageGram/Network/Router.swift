//
//  Router.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import Alamofire


/**
 * Central source for network routing in the app.
 */
enum Router: URLRequestConvertible {
    case getPhotos

    var method: HTTPMethod { return .get }

    static let baseURLString = "http://jsonplaceholder.typicode.com"

    var path: String {
        switch self {
        case .getPhotos:
            return "photos"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}


//MARK: EndpointSampleStringConvertable
extension Router: EndpointSampleStringConvertable {
    var endpointSampleString: String {
        switch self {
        case .getPhotos:
            return "{" +
                        "albumId: 1," +
                        "id: 25," +
                        "title: \"facere non quis fuga fugit vitae\"," +
                        "url: \"http://placehold.it/600/5e3a73\"," +
                        "thumbnailUrl: \"http://placehold.it/150/5e3a73\"" +
                    "}"
        }
    }
}
