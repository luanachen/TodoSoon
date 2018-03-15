//
//  Category.swift
//  TodoSoon
//
//  Created by Luana on 15/03/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}

