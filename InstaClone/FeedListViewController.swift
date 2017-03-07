//
//  FeedListViewController.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import AlamofireImage

class FeedListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var feeds: [Feed] = []
    var feedToShow: Feed?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCell()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 240
        downloadFeed()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let feedDetailViewController = segue.destination as? FeedDetailViewController {
            feedDetailViewController.feed = feedToShow
        }
        super.prepare(for: segue, sender: sender)
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "FeedCell", bundle: Bundle.main), forCellReuseIdentifier: String(describing: FeedCell.self))
    }
    
    private func downloadFeed() {
        let urlString = "http://localhost:8888/feeds.json"
        Alamofire.request(urlString).responseObject { [weak self] (response: DataResponse<FeedListResponse>) in
            if let feeds = response.result.value?.feeds {
                self?.feeds = feeds
                self?.tableView.reloadData()
            } else {
                //TODO handle error
            }
        }
    }
    
    fileprivate func showDetail(for feed: Feed) {
        feedToShow = feed
        performSegue(withIdentifier: "showFeedDetail", sender: self)
    }
}

extension FeedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let feed = feeds[indexPath.row]
        showDetail(for: feed)
    }
}

extension FeedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedCell.self)) as! FeedCell
        let feed = feeds[indexPath.row]
        
        cell.userIdLabel.text = feed.user?.username
        cell.feedTitleLabel.text = feed.title
        if let imageUrlString = feed.imageUrl, let imageUrl = URL(string: imageUrlString) {
            cell.feedImageView.af_setImage(withURL: imageUrl)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
}
