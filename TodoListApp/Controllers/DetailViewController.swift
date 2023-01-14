//  DetailViewController.swift
//  TodoListApp
//  Created by 近江伸一 on 2022/10/31.
import UIKit
import RealmSwift
class DetailViewController: UIViewController {
    let realm = try! Realm()
    var data: Results<TodoListItem>!
    public var item: TodoListItem?
   // public var deletionHandler: (()->Void)?
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
   
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM d yyyy hh:mm", options: 0, locale: Locale(identifier: "ja_JP"))
        return df
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(TodoListItem.self).sorted(byKeyPath: "date",ascending: true)
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        itemLabel.text = item?.item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(goTrash))
        navigationItem.titleView?.tintColor = .white
        itemLabel.sizeToFit()
    }
    @objc func goTrash(){
        guard let myItem = self.item else { return }
       try! realm.write{
            realm.delete(myItem)
        }
      //  deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}
