//
//  FeedDetailViewController.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import AlamofireImage

class FeedDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyTableViewLabel: UILabel!
    var refreshControl: UIRefreshControl!
    
    var feed: Feed?
    var comments: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        registerCell()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
        self.tableView.allowsSelection = false
        emptyTableViewLabel.isHidden = true
        
        refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "FeedCell", bundle: Bundle.main), forCellReuseIdentifier: String(describing: FeedCell.self))
        tableView.register(UINib(nibName: "CommentCell", bundle: Bundle.main), forCellReuseIdentifier: String(describing: CommentCell.self))
    }
    
    public func refreshData() {
        if let feedId = feed?.feedId {
            downloadComments(for: feedId)
        }
    }
    
    private func downloadComments(for feedId: Int64) {
        if !refreshControl.isRefreshing {
            refreshControl.beginRefreshing()
        }
        let urlString = "http://localhost:8888/feeds/\(feedId)/comments.json"
        emptyTableViewLabel.isHidden = true
        Alamofire.request(urlString).responseObject { [weak self] (response: DataResponse<CommentListResponse>) in
            sleep(2)
            if let refreshControl = self?.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            if let comments = response.result.value?.comments {
                self?.comments = comments
                self?.tableView.reloadData()
            } else {
                //TODO handle error
                self?.emptyTableViewLabel.isHidden = false
            }
        }
    }
}

extension FeedDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FeedDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // feed cell
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedCell.self)) as! FeedCell
            if let feed = feed {
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
            }
            
            return cell
        default:
            // comment cell
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CommentCell.self)) as! CommentCell
            let comment = comments[indexPath.row-1]
            cell.userIdLabel.text = comment.user?.username
            cell.commentLabel.text = comment.comment
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + comments.count
    }
}
