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


enum API {
    static func getPhotos() -> Observable<[Photo]> {
        return Observable.create { observer -> Disposable in
            Alamofire.request(Router.getPhotos).responseCollection(completionHandler: { (response: DataResponse<[Photo]>) in
                if let photos = response.result.value {
                    observer.on(.next(photos))
                    observer.on(.completed)
                }
            })
            return Disposables.create()
        }
    }
}
