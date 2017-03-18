//
//  EndpointSampleStringConvertable.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation


/**
 * A protocol to assist in writing more expressive end points.
 * Having a sample representation of what the endpoint looks like
 * can greatly assist the developer - since they don't have to pop
 * open the browser to see what the expected data should look like.
 */
protocol EndpointSampleStringConvertable {
    var endpointSampleString: String { get }
}
