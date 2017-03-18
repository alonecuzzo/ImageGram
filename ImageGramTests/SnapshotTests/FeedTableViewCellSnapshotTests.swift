//
//  FeedTableViewCellSnapshotTests.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import FBSnapshotTestCase

@testable import ImageGram


class FeedTableViewCellSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testThatCellRendersCorrectly() {
        let cell = FeedTableViewCell(frame: .zero)
        cell.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 300)
        cell.contentView.backgroundColor = .white
        let bundle = TestHelper.shared.bundle
        let path = bundle.path(forResource: "theowl", ofType: "png")
        let owl = UIImage(contentsOfFile: path!)!
        cell.photoImageView.image = owl
        cell.photoTitle = "Every Wise Owl Loves a Spa Day!"
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        FBSnapshotVerifyView(cell)
        FBSnapshotVerifyLayer(cell.layer)
    }
}
