//
//  ToDoTListTableViewController.swift
//  TodoSoon
//
//  Created by Luana on 13/03/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit
import CoreData

class ToDoTListTableViewController: UITableViewController {
    
    // MARK: Variable instances
    var itemArray = [Item]()
    let itemManager = ItemManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    // MARK: ViewCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemArray = itemManager.loadItems(in: context)
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
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        itemManager.saveItems(itemArray, context: context)
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            self.itemManager.saveItems(self.itemArray, context: self.context)
            
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

// MARK: UISearchBarDelegate

extension ToDoTListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        searchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        searchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        itemArray = itemManager.loadItems(in: context, with: searchRequest)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            itemArray = itemManager.loadItems(in: context)
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}




