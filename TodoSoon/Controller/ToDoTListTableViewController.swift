//
//  ToDoTListTableViewController.swift
//  TodoSoon
//
//  Created by Luana on 13/03/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit

class ToDoTListTableViewController: UITableViewController {
    
    // MARK: Variable instances
    var itemArray = [ItemModel]()
    let itemManager = ItemManager()
    
    // MARK: ViewCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemArray = itemManager.loadItems()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        itemManager.saveItems(itemArray)
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = ItemModel()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.itemManager.saveItems(self.itemArray)
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print(alertTextField.text!)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
   

}
