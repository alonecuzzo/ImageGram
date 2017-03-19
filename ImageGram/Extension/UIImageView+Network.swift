//
//  UIImageView+Network.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/19/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage


/// Isolating AlamofireImage - just incase we want to swap the framework
/// or use NSURLSession or something like that.
extension UIImageView {
    func setImage(url: URL) {
        self.af_setImage(withURL: url)
    }
}
