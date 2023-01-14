//
//  Helper.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2022/11/19.
//

import Foundation
import NotificationCenter
import RealmSwift

class Helper{
    let realm = try! Realm()
    func saveDate(text:String,date: Date){
       let newItem = TodoListItem()
        newItem.date = date
        newItem.item = text
        newItem.id = String(Int.random(in: 0...99999))
        try! realm.write{
            realm.add(newItem)
        }
        notification(alert: newItem)
    }
    func notification(alert: TodoListItem){
        let targetAlert = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: alert.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: targetAlert, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = alert.item
        content.sound = .default
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    func deleteItem(item:TodoListItem,token:NotificationToken){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id])
        try! realm.write(withoutNotifying: [token]){
            realm.delete(item)
        }
        
    }
}
