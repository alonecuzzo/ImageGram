//
//  FeedViewModelSpec.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import OHHTTPStubs
import Quick
import Nimble
import RxSwift
import Alamofire

@testable import ImageGram

//MAYBE DO SHALLOW VERSION AND DEEP VERSION OF THE VIEW MODEL TEST

class FeedViewModelSpec: QuickSpec {
    
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
                
                it("should return Photos with the proper album ids.") {
                    
                    //GIVEN
                    
                    let vm = FeedViewModel()
                    
                    waitUntil(timeout: 2, action: { done in
                        vm.photos.asObservable().filter { $0.count > 0 }.subscribe(onNext: { photos in
                            let idsFromAPI = photos.map { $0.albumID }
                            
                            //THEN
                            
                            expect(idsFromAPI).to(equal(FeedViewModelSpec.stubbedAlbumIDs))
                            
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

class TestHelper {
    static let shared = TestHelper()
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
}


//MARK: Helper
extension FeedViewModelSpec {
    fileprivate static var stubbedAlbumIDs: [Int] {
        
         let bundle = TestHelper.shared.bundle
         guard let path = bundle.path(forResource: "photos", ofType: "json") else { fatalError("error finding photos.json file") }
         let jsonData =  Data(referencing: NSData(contentsOfFile: path)!)

         do {
             guard let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSArray else { fatalError("error converting json with serializer") }
             return jsonResult.map { item -> Int in
                 let item = item as! Dictionary<String, Any>
                 return item["albumId"] as! Int
             }
         } catch {
             fatalError("converting json failed")
         }
    }
}
