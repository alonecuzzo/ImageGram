//
//  FeedViewController.swift
//  ImageGram
//
//  Created by Jabari Bell on 3/18/17.
//  Copyright © 2017 theowl. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import Alamofire


struct FeedViewModel {
    
}


class FeedViewController: UIViewController {
    
    //MARK: Property
    private let tableView = UITableView(frame: .zero)
    private let viewModel: FeedViewModel //perhaps can be protocol constrained - bound to a generic type
    private let disposeBag = DisposeBag()

    
    //MARK: Lifecycle
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("The FeedViewController has not been designed to work with xibs. It needs a FeedViewModel passed via dependency injection to be created.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    //MARK: Setup
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        API.getPhotos().subscribe(onNext: { photos in
            print("got the photos! \(photos.count) photos")
        }).addDisposableTo(disposeBag)
    }
}
