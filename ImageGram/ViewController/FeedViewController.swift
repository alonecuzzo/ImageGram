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
import RxCocoa
import AlamofireImage


class FeedViewController: UIViewController {
    
    //MARK: Property
    private let tableView = UITableView(frame: .zero)
    private let viewModel: FeedViewModel //perhaps can be protocol constrained - bound to a generic type
    private lazy var photos: Observable<[Photo]> = { [unowned self] in
       return self.viewModel.photos.asObservable()
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    override var prefersStatusBarHidden: Bool { return true }
    
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
        setupBindings()
        viewModel.getPhotos()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tableView.rowHeight = 200
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func setupBindings() {
        photos.bindTo(tableView.rx.items) { tv, row, photo in
            FeedTableViewCellFactory.feedCell(tv, forRow: row, photo: photo)
        }.addDisposableTo(disposeBag)
        
        tableView.rx.modelSelected(Photo.self).subscribe(onNext: { photo in
            self.presentPhotoViewController(photo)
        }).addDisposableTo(disposeBag)
    }
    
    //presenter?
    private func presentPhotoViewController(_ photo: Photo) {
        let photoViewController = PhotoViewController(photoURL: photo.url)
        photoViewController.exitClosure = { pvc in
            pvc.willMove(toParentViewController: nil)
            pvc.view.removeFromSuperview()
            pvc.removeFromParentViewController()
        }
        addChildViewController(photoViewController)
        view.addSubview(photoViewController.view)
        photoViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        photoViewController.didMove(toParentViewController: self)
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.getPhotos()
        refreshControl.endRefreshing()
    }
}
