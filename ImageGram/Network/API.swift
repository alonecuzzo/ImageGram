//
//  API.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire


/**
 * Enum used for making API calls.
 */
enum API {

    /**
     * Makes call to the api and returns and observable of Photo
     * objects.
     */
    static func getPhotos() -> Observable<[Photo]> {
        return Observable.create { observer -> Disposable in
            Alamofire.request(Router.getPhotos).responseCollection(completionHandler: { (response: DataResponse<[Photo]>) in
                if let photos = response.result.value {
                    observer.on(.next(photos))
                    observer.on(.completed)
                }
                //NOTE: I am not handling error states because the api
                //      as presented in the challenge works, and I stated
                //      in the README that I'd be assuming the happy path for
                //      this iteration.  But if errors needed to be added, this
                //      is where an error would be plugged into head down stream
                //      to subscribers.
            })
            return Disposables.create()
        }
    }
}
