//
//  TestHelper.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/19/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation


class TestHelper {
    static let shared = TestHelper()
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
}
