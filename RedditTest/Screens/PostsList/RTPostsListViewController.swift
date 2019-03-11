//
//  RTPostsListViewController.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

protocol RTPostsListDelegate {
    func postselected(_ post: RTPost)
}

class RTPostsListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    lazy private var presenter = RTPostsListPresenter(delegate: self)
    
    var delegate: RTPostsListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.presenter.fetchPosts()
    }
    
    func setUpView() {
        self.setUpNavigation()
        self.setUpTableView()
    }
    
    func setUpNavigation() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.barTintColor = UIColor.style(.one)
        self.navigationController?.navigationBar.tintColor = UIColor.style(.three)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.style(.two)]
        
        self.title = "Reddit Posts"
    }
    
    func setUpTableView() {
        self.tableView.backgroundColor = UIColor.style(.one)
        self.tableView.clearExtraSeparators()
        self.tableView.registerCellNib(RTPostTableViewCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension RTPostsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.presenter.heightForRow()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRows()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.presenter.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let post = self.presenter.selectPost(indexPath)
        tableView.reloadRows(at: [indexPath], with: .none)
        self.delegate?.postselected(post)
    }
}

extension RTPostsListViewController: RTPostsListPresenterDelegate {
    func fetchStarted() {
        
    }
    
    func fetchEnded() {
        self.tableView.reloadData()
    }
    
    func fetchError(_ error: Error?) {
        
    }
}
