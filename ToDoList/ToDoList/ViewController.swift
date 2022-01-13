//
//  ViewController.swift
//  ToDoList
//
//  Created by Jiya Garg on 10/01/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
    
    private let table: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier:"cell" )
        return table
    }()
    var items = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
    }
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "new item", message: "enter to new to do list item", preferredStyle: .alert)
        alert.addTextField{field in field.placeholder = "enter item.."}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {[weak self](_)in if let field = alert.textFields?.first{
            if let text = field.text , !text.isEmpty {
                //enter new to do list item
                DispatchQueue.main.async {
                    var currentItems =  UserDefaults.standard.stringArray(forKey: "items") ?? []
                    currentItems.append(text)
                    _ = [text]
                    UserDefaults.standard.setValue(currentItems, forKey: "items")
                    self?.items.append(text)
                    self?.table.reloadData()
                }
                
            }
        }}))
        present(alert, animated: true)
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    

}

