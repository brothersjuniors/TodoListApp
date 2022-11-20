//
//  AddViewController.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2022/10/31.
//

import UIKit
import RealmSwift
import NotificationCenter
class AddViewController: UIViewController {
    var data: Results<TodoListItem>!
    @IBOutlet var textField: UITextField!
    @IBOutlet var picker: UIDatePicker!
    let realm = try! Realm()
    public var complitionHandler:(()->Void)?
    let df = DateFormatter()
    var date = Date()
    private let todo = TodoListItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        // picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .dateAndTime
        picker.setDate(date, animated: true)
        textField.becomeFirstResponder()
        data = realm.objects(TodoListItem.self).sorted(byKeyPath: "date",ascending: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done,target: self,action: #selector (tapSaveButton))
    }
    func format(date:Date)-> String{
        df.dateFormat = "MMM d yyyy hh:mm"
        let strDate = df.string(from: date)
        return strDate
    }
    @objc func tapSaveButton(){
        if let text = textField.text, !text.isEmpty {
            _ = picker.date
            let _: DateFormatter = {
                // DateFormatter を使用して書式とロケールを指定する
                df.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM d yyyy hh:mm", options: 0, locale: Locale(identifier: "ja_JP"))
                return df
            }()
            Helper().notification(alert: todo)
            Helper().saveDate(text: textField.text!, date: picker.date)
            //     print(todo.item,todo.date)
            dismiss(animated: true)
            navigationController?.popViewController(animated: true)
        }else{
        }
    }
}
