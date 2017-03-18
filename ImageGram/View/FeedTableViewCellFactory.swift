//
//  FeedTableViewCellFactory.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage


enum FeedTableViewCellFactory {
    
    static func feedCell(_ tableView: UITableView, forRow row: Int, photo: Photo) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier) as! FeedTableViewCell
        
        cell.photoImageView.af_setImage(withURL: photo.thumbnailURL)
        cell.photoTitle = photo.title
        
        return cell
    }
}
