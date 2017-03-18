//
//  PhotoViewController.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import Foundation
import UIKit


class PhotoViewController: UIViewController {
    
    //MARK: Property
    private let imageView = UIImageView(frame: .zero)
    var exitClosure: ((PhotoViewController) -> Void)?
    let photoURL: URL
    
    
    //MARK: Method
    init(photoURL: URL) {
        self.photoURL = photoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cannot be created without a backing photo url.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.9)
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.height.equalTo(600) //should we keep at 600? or fit it on the screen
        }
        
        view.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        view.addGestureRecognizer(freshTapRecognizer())
        imageView.addGestureRecognizer(freshTapRecognizer())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.af_setImage(withURL: photoURL)
    }
    
    @objc private func exitPhotoViewController() {
        exitClosure?(self)
    }
    
    private func freshTapRecognizer() -> UITapGestureRecognizer {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(exitPhotoViewController))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        return tapRecognizer
    }
}