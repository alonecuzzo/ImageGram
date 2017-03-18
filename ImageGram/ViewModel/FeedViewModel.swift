//
//  FeedViewModel.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import RxSwift


/**
 * Contains a variable photos that is to serve as a datasource
 * for owning objects.
 */
struct FeedViewModel {

    //MARK: Property
    let photos = Variable([Photo]())
    private let disposeBag = DisposeBag()


    //MARK: Method

    /**
     * Accesses the API endpoint for getting photos and updates the
     * photos variable after making any neccesary transformations to
     * the data.
     */
    func getPhotos() {
        API.getPhotos().subscribe(onNext: { photos in
            self.photos.value = photos
        }).addDisposableTo(disposeBag)
    }
}
