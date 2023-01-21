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
    
    //MARK: -Override Methods
    override func loadView() {
        super.loadView()
        tableView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        tableView.dataSource = self
    }
    
    //MARK: -Private Methods
    private func setupView() {
        addSubView()
        setupNavigationController()
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(indexPath.row)"
        cell.contentConfiguration = content
        return cell
    }
}
