//
//  ItemManager.swift
//  TodoSoon
//
//  Created by Luana on 14/03/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit
import CoreData

class ItemManager {
    
    func saveItems(_ array: [Item], context: NSManagedObjectContext) {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems(in context: NSManagedObjectContext, with request: NSFetchRequest<Item> = Item.fetchRequest(), by predicate: NSPredicate? = nil) -> [Item]{
        
        request.predicate = predicate
        
        var itemArray = [Item]()
        do {
            itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
        
        return itemArray
    }
}

