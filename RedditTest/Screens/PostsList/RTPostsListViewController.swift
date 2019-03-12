//
//  RTPostsListViewController.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

class RTPostsListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    lazy private var presenter = RTPostsListPresenter(delegate: self)
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.presenter.fetchPosts()
    }
    
    private func setUpView() {
        self.setUpNavigation()
        self.setUpTableView()
    }
    
    private func setUpNavigation() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.barTintColor = UIColor.style(.one)
        self.navigationController?.navigationBar.tintColor = UIColor.style(.three)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.style(.two)]
        
        let item = UIBarButtonItem(title: "Dismiss all", style: .done, target: self, action: #selector(self.dismissAll))
        self.navigationItem.rightBarButtonItem = item
        
        self.title = "Reddit Posts"
    }
    
    private func setUpTableView() {
        self.tableView.backgroundColor = UIColor.style(.one)
        self.tableView.clearExtraSeparators()
        self.tableView.registerCellNib(RTPostTableViewCell.self)
        
        self.tableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @objc private func dismissAll() {
        if self.presenter.numberOfRows() > 0 {
            var indexPaths = [IndexPath]()
            for i in 0...(self.presenter.numberOfRows() - 1) {
                indexPaths.append(IndexPath(row: i, section: 0))
            }
            self.presenter.dismissAllPosts()
            self.tableView.deleteRows(at: indexPaths, with: .left)
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.presenter.fetchPosts()
    }
    
    private func stopRefresh() {
        DispatchQueue.main.async {
            self.self.refreshControl.endRefreshing()
        }
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
        
        if let detailsController = RTDetailsViewController.instanceViewController(post: post) {
            self.splitViewController?.showDetailViewController(detailsController, sender: self)
        }
    }
}

extension RTPostsListViewController: RTPostsListPresenterDelegate {
    func fetchStarted() {
        self.refreshControl.beginRefreshing()
    }
    
    func fetchEnded() {
        self.stopRefresh()
        self.tableView.reloadData()
    }
    
    func fetchError(_ error: Error?) {
        self.stopRefresh()
    }
    
    func deleteCell(indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .left)
    }
}
