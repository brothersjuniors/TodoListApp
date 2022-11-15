//  DetailViewController.swift
//  TodoListApp
//  Created by 近江伸一 on 2022/10/31.
import UIKit
import RealmSwift
class DetailViewController: UIViewController {
    public var item: TodoListItem?
    public var deletionHandler: (()->Void)?
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    private let realm = try! Realm()
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate:  "yyyy-MM-dd", options: 0, locale: Locale(identifier: "ja_JP"))
        return dateFormatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(goTrash))
        navigationItem.titleView?.tintColor = .white
        itemLabel.sizeToFit()
    }
    @objc func goTrash(){
        guard let myItem = self.item else { return }
        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}
