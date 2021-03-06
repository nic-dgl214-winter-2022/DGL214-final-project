//
//  SearchResultsViewController.swift
//  Grocerylist
//
//  Created by Taiwo Adekanmbi on 2022-03-10.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject{
    func logData(_ result: String)
}

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private var results: [GroceryProducts] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    
    weak var delegate: (SearchResultsViewControllerDelegate)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with results: [GroceryProducts]) {
        self.results = results
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = results[indexPath.row]
        print("ANSWER \(result.name)")
        Folders.addNewGrocery(grocery: GroceryProducts(name: result.name, categories: false), index: 1)
        tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row].name
        return cell
    }
  
}
