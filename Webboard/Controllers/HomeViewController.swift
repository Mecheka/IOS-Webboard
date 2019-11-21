//
//  HomeViewController.swift
//  Webboard
//
//  Created by Suriya on 27/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: .valueChanged)
        return refreshControl
    }()
    
    var service = Service()
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationTableView()
        loadAllPost()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func configurationTableView() {
        tableView.refreshControl = refreshControl
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        loadAllPost()
    }
    
    private func loadAllPost() {
//        SVProgressHUD.show()
        service.getAllPost {  [weak self] result in
//            SVProgressHUD.dismiss()
            self?.refreshControl.endRefreshing()
            
            switch result {
            case .success(let posts):
                self?.posts = posts
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
//                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }

}

// MARK: - Tableview
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        cell.setup(title: post.title, name: post.content)
        return cell
    }
}
