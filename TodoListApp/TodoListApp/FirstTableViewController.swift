//
//  FirstTableViewController.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2022/10/31.
//

import UIKit
import RealmSwift

class FirstTableViewController: UITableViewController {
    let realm = try! Realm()
    //TodoListItemをdataとしてインスタンス化
    private var data = [TodoListItem]()
 override func viewDidLoad() {
        super.viewDidLoad()
        //dataにデータを入力
        data = realm.objects(TodoListItem.self).map({ $0 })
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
 }
    // MARK: - Table view data source
override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return data.count
    }
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //data情報をcellに表示
        cell.textLabel?.text = data[indexPath.row].item
      return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        //DetailViewControllerをvcにセット
        guard let vc = storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController else { return }
        //FirstTableViewControllerのdataをDetailViewControllerのvcにセット
        vc.item = item
        vc.deletionHandler = {[weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        //data[indexPath.row]データの表示データをDetailViewControllerのtitleに表示
        vc.title = item.item
//自動でDetailViewControllerへ遷移
        navigationController?.pushViewController(vc, animated: true)
    }
 @IBAction func dateAddButton(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController else { return }
        vc.complitionHandler = { [weak self] in
            self?.refresh()
  }
        vc.title = "New Item"
        vc.navigationItem.largeTitleDisplayMode = .automatic
        //自動でDetailViewControllerへ遷移
        navigationController?.pushViewController(vc, animated: true)
 }
    func refresh(){
        data = realm.objects(TodoListItem.self).map({ $0 })
        tableView.reloadData()
    }
}
