//
//  TableViewController.swift
//  Project4
//
//  Created by Ильфат Салахов on 21.01.2023.
//

import UIKit

final class TableViewController: UIViewController {
    
    // MARK: -Private Property
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var websites = ["hackingwithswift.com", "google.com"]
    
    //MARK: -Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: -Private Methods
    private func setupView() {
        addSubView()
        setupNavigationController()
        tableView.frame = view.bounds
    }

    private func addSubView() {
        view.addSubview(tableView)
    }
    
    private func setupNavigationController() {
        title = "Sites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


// MARK: UITableViewDataSource
extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        websites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let website = websites[indexPath.row]
        content.text = "\(website)"
        cell.contentConfiguration = content
        return cell
    }
}
extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainViewController = MainViewController()
        let website = websites[indexPath.row]
        mainViewController.website = website
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(mainViewController, animated: true)
    }
}
