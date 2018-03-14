//
//  ItemManager.swift
//  TodoSoon
//
//  Created by Luana on 14/03/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import Foundation

class ItemManager {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    func saveItems(_ array: [ItemModel]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(array)
            try data.write(to: dataFilePath!)
            print("data saved")
        }
        catch {
            print("Error encoding item array \(error)")
        }
    }
    
    func loadItems() -> [ItemModel]{
        var array = [ItemModel]()
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                array = try decoder.decode([ItemModel].self, from: data)
            }
            catch {
                print("Error decoding item array \(error)")
            }
        }
        return array
    }
}

