//
//  CalenderView.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2022/11/03.
//

import UIKit
import RealmSwift
import FSCalendar
class CalenderView: UIViewController,FSCalendarDelegate,FSCalendarDataSource,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var data = [TodoListItem]()
    let timeStyle = "yyyy年MM月dd日"
    //今日の日付
    let dt = Date()
    let df = DateFormatter()
    fileprivate weak var calendar: FSCalendar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cells")
        let realm = try! Realm()
        data = realm.objects(TodoListItem.self).sorted(byKeyPath: "date",ascending: true).map({ $0 })
        // DateFormatter を使用して書式とロケールを指定する
        df.dateFormat = DateFormatter.dateFormat(fromTemplate: timeStyle, options: 0, locale: Locale(identifier: "ja_JP"))
    
        tableView.reloadData()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let realm = try! Realm()
//        data = realm.objects(TodoListItem.self).map({ $0 })
////        configureRefreshControl()
//        tableView.reloadData()
//    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        tableView.reloadData()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
        textField.isEnabled = false
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let realm = try! Realm()
        data = realm.objects(TodoListItem.self).sorted(byKeyPath: "date",ascending: true).map({ $0 })
        label.text = df.string(from: date)
        df.timeStyle = .none
        df.dateStyle = .long
        df.locale = Locale(identifier: "ja_JP")
        //今の日付とdate内の日付の一致
        if df.string(from: dt) == df.string(from: date) {
            print("same day!")
        }else {
            print("not same day!")
        }
        tableView.reloadData()
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        df.dateFormat = timeStyle
        
        for num in 0..<data.count where df.string(from: date) == df.string(from: data[num].date) {
            
            return 1
        }
        
        return 0
    }
    
}
