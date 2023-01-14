//
//  TodoListItem.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2022/10/31.
//

import Foundation
import RealmSwift
class TodoListItem: Object{
    @objc dynamic var item = ""
    @objc dynamic var date = Date()
    @objc dynamic var id = ""
   
    
}
class ItemList: Object{
    let list = List<TodoListItem>()
}
 
