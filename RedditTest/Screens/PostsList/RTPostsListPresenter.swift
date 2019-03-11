//
//  RTPostsListPresenter.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

protocol RTPostsListPresenterDelegate {
    func fetchStarted()
    func fetchEnded()
    func fetchError(_ error: Error?)
}

class RTPostsListPresenter {
    private let service = RTTopPostsService()
    private var delegate: RTPostsListPresenterDelegate?
    
    private var posts = [RTPost]()
    
    convenience init(delegate: RTPostsListPresenterDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    func fetchPosts() {
        self.delegate?.fetchStarted()
        self.service.get(success: { (posts) in
            self.posts = posts
            self.fetchEnded()
        }) { (error) in
            self.delegate?.fetchError(error)
        }
    }
    
    private func fetchEnded() {
        DispatchQueue.main.async {
            self.delegate?.fetchEnded()
        }
    }
    
    func heightForRow() -> CGFloat {
        return 150
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(RTPostTableViewCell.self) else { return UITableViewCell() }
        let post = self.posts[indexPath.row]
        cell.setUpValues(post: post)
        return cell
    }
    
    func selectPost(_ indexPath: IndexPath) -> RTPost {
        let post = self.posts[indexPath.row]
        post.data.readed = true
        return post
    }
}
