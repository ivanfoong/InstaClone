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
    @IBOutlet weak var emptyTableViewLabel: UILabel!
    var refreshControl: UIRefreshControl!
    
    var feeds: [Feed] = []
    var feedToShow: Feed?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        registerCell()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 240
        emptyTableViewLabel.isHidden = true
        
        refreshData()
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
    
    public func refreshData() {
        downloadFeed()
    }
    
    private func downloadFeed() {
        if !refreshControl.isRefreshing {
            refreshControl.beginRefreshing()
        }
        let urlString = "http://localhost:8888/feeds.json"
        emptyTableViewLabel.isHidden = true
        Alamofire.request(urlString).responseObject { [weak self] (response: DataResponse<FeedListResponse>) in
            sleep(2)
            if let refreshControl = self?.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            if let feeds = response.result.value?.feeds {
                self?.feeds = feeds
                self?.tableView.reloadData()
            } else {
                //TODO handle error
                self?.emptyTableViewLabel.isHidden = false
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        if let timestamp = feed.timestamp {
            let date = Date(timeIntervalSince1970: Double(timestamp))
            cell.timestampLabel.text = dateFormatter.string(from: date)
        }
        if let imageUrlString = feed.imageUrl, let imageUrl = URL(string: imageUrlString) {
            cell.feedImageView.af_setImage(withURL: imageUrl)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
}
