//
//  DeepFeedViewModelSpec.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/19/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import OHHTTPStubs
import Quick
import Nimble
import RxSwift
import Alamofire

@testable import ImageGram

/**
 * This is an example of a deeper test of the FeedViewModel
 * where two collections of Photos are compared.
 */
class DeepFeedViewModelSpec: QuickSpec {

    private let disposeBag = DisposeBag()

    override func spec() {

        describe("A FeedViewModel") {

            //STUB ENDPOINT

            stub(condition: { request -> Bool in
                return request.url?.absoluteString == Router.getPhotos.urlRequest?.url?.absoluteString
            }, response: { request -> OHHTTPStubsResponse in
                return  OHHTTPStubsResponse(
                    fileAtPath: OHPathForFile("photos.json", type(of: self))!,
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"]
                )
            })

            context("makes a call to the API") {

                it("should return a collection of Photos that match the collection built directly from the stubbed JSON.") {

                    //GIVEN

                    let vm = FeedViewModel()

                    waitUntil(timeout: 2, action: { done in
                        vm.photos.asObservable().filter { $0.count > 0 }.subscribe(onNext: { photos in

                            //THEN

                            expect(photos).to(equal(DeepFeedViewModelSpec.stubbedPhotos))

                            done()

                        }).addDisposableTo(self.disposeBag)

                        //WHEN

                        vm.getPhotos()
                    })
                }
            }
        }
    }
}


//MARK: Equatable

/**
 * Isolating the extension in this test because there is not a use
 * case in the code base for it.  If one presented itself, I'd move
 * this code there.
 */
extension Photo: Equatable {}

public func ==(lhs: Photo, rhs: Photo) -> Bool {
    return lhs.albumID == rhs.albumID && lhs.thumbnailURL == rhs.thumbnailURL && lhs.title == rhs.title && lhs.url == rhs.url
}


//MARK: Helper
extension DeepFeedViewModelSpec {
    fileprivate static var stubbedPhotos: [Photo] {

        let bundle = TestHelper.shared.bundle
        guard let path = bundle.path(forResource: "photos", ofType: "json") else { fatalError("error finding photos.json file") }
        let jsonData =  Data(referencing: NSData(contentsOfFile: path)!)

        do {
            guard let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSArray else { fatalError("error converting json with serializer") }
            return jsonResult.map { item -> Photo in
                let item = item as! Dictionary<String, Any>
                let dummyResponse = HTTPURLResponse()
                return Photo(response: dummyResponse, representation: item)!
            }
        } catch {
            fatalError("converting json failed")
        }
    }
}
