//
//  AddViewController.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2022/10/31.
//

import UIKit
import RealmSwift
class AddViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var picker: UIDatePicker!
    let timeStyle = "yyyy年MM月dd日"
    private let realm = try! Realm()
    public var complitionHandler:(()->Void)?
    let df = DateFormatter()
    var date = Date()
 override func viewDidLoad() {
        super.viewDidLoad()
     picker.preferredDatePickerStyle = .compact
     picker.datePickerMode = .date
     
            
     textField.becomeFirstResponder()
     picker.setDate(date, animated: true)
     navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done,target: self,action: #selector (tapSaveButton))
 }
    func format(date:Date)->String{
   let dateformatter = DateFormatter()
          dateformatter.dateFormat = timeStyle
          let strDate = dateformatter.string(from: date)
        return strDate
      }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//         textField.resignFirstResponder()
//     }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            textField.resignFirstResponder()
//            return true
//        }
  @objc func tapSaveButton(){
        if let text = textField.text, !text.isEmpty {
            let date = picker.date
       let _: DateFormatter = {
                let dateFormatter = DateFormatter()
                // DateFormatter を使用して書式とロケールを指定する
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate:  timeStyle, options: 0, locale: Locale(identifier: "ja_JP"))
                return dateFormatter
            }()
            realm.beginWrite()
            let newItem = TodoListItem()
            newItem.date = date
            newItem.item = text
            realm.add(newItem)
            try! realm.commitWrite()
            complitionHandler?()
            navigationController?.popViewController(animated: true)
        }else{
            print("Add time")
        }}}
