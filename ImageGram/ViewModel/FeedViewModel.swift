//
//  FeedViewModel.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import RxSwift

struct FeedViewModel {
    
    //MARK: Property
    let photos = Variable([Photo]())
    private let disposeBag = DisposeBag()
    
    
    //MARK: Method
    func getPhotos() {
        API.getPhotos().subscribe(onNext: { photos in
            self.photos.value = photos
        }).addDisposableTo(disposeBag)
    }
}
