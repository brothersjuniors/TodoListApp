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
    private var data: Results<TodoListItem>!
    private let timeStyle = "yyyy年MM月dd日"
    //今日の日付
    private let dt = Date()
    private let df = DateFormatter()
    fileprivate weak var calendar: FSCalendar!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return "Todo"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let realm = try! Realm()
        data = realm.objects(TodoListItem.self).sorted(byKeyPath: "date",ascending: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarTableViewCell
        
        
        df.dateStyle = .long
        df.timeStyle = .short
        df.locale = Locale(identifier: "ja_JP")
        cell.dateLabel!.text = df.string(from: data[indexPath.row].date)
       
      cell.todoLabel.text = data[indexPath.row].item
     
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.register(UINib(nibName:"CalendarTableViewCell",bundle: nil), forCellReuseIdentifier: "cell")
        let realm = try! Realm()
        data = realm.objects(TodoListItem.self).sorted(byKeyPath: "date",ascending: true)
        // DateFormatter を使用して書式とロケールを指定する
        df.dateFormat = DateFormatter.dateFormat(fromTemplate: timeStyle, options: 0, locale: Locale(identifier: "ja_JP"))
        tableView.reloadData()
    }
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
        df.timeStyle = .none
        df.dateStyle = .long
        df.locale = Locale(identifier: "ja_JP")
        label.text = df.string(from: date)
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        df.dateFormat = timeStyle
        for num in 0..<data.count where df.string(from: date) == df.string(from: data[num].date) {
            return 1
        }
        return 0
    }
}
