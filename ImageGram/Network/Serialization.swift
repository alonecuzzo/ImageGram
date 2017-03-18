//
//  Serialization.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import Alamofire


//This file is heavily taken from Alamofire's serialization guide.

protocol LocalObjectSerializable {
    init?(dictionary: [String: Any])
    var dictionaryValue: [String: Any] { get }
}

protocol ResponseObjectSerializableType {}

protocol ResponseObjectSerializable: ResponseObjectSerializableType {
    init?(response: HTTPURLResponse, representation: Any)
}

extension DataRequest {
    @discardableResult
    func responseObject<T: ResponseObjectSerializable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in

            //NOTE: Error handling would go here.

            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)

            guard case let .success(jsonObject) = result else {
                fatalError("CRASH ON SERIALIZING")
                //NOTE: Error handling would go here.
            }

            let responseObject = T(response: response!, representation: jsonObject)!
            return .success(responseObject)
        }
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

protocol ResponseCollectionSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation: Any) -> [Self]
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self] {
        var collection: [Self] = []
        if let representation = representation as? [[String: Any]] {
            for itemRepresentation in representation {
                if let item = Self(response: response, representation: itemRepresentation) {
                    collection.append(item)
                }
            }
        }
        return collection
    }
}

extension DataRequest {
    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self
    {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            //NOTE: Error handling would go here.
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)

            guard case let .success(jsonObject) = result else {
                fatalError("CRASH ON SERIALIZING")
                //NOTE: I am assuming the happy path for this project.
                //      I would add error handling here, if there was a failure
                //      on serializing.
            }
            return .success(T.collection(from: response!, withRepresentation: jsonObject))
        }

        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
