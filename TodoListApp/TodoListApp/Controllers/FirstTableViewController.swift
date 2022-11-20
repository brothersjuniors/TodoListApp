//
//  FirstTableViewController.swift
//  TodoListApp
//
//  Created by 近江伸一 on 2022/10/31.
//

import UIKit
import RealmSwift
class FirstTableViewController: UITableViewController {
    var data: Results<TodoListItem>!
    let realm = try! Realm()
    var token: NotificationToken!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        data = realm.objects(TodoListItem.self).sorted(byKeyPath: "date",ascending: true)
        token = realm.observe{ notification,realm in
            self.tableView.reloadData()
        }
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.item
        print(item)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        //DetailViewControllerをvcにセット
        guard let vc = storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController else { return }
        //FirstTableViewControllerのdataをDetailViewControllerのvcにセット
        vc.item = item
        vc.navigationItem.largeTitleDisplayMode = .never
        //data[indexPath.row]データの表示データをDetailViewControllerのtitleに表示
        vc.title = item.item
        //DetailViewControllerへ遷移
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
        data = realm.objects(TodoListItem.self).sorted(byKeyPath: "date",ascending: true)
        tableView.reloadData()
    }
    @IBAction func goCalendar(_ sender: Any) {
        guard let cale = storyboard?.instantiateViewController(withIdentifier: "CalenderView") as? CalenderView else { return }
        
        cale.title = "Calendar"
        cale.navigationItem.largeTitleDisplayMode = .automatic
        //自動でDetailViewControllerへ遷移
        navigationController?.pushViewController(cale, animated: true)
    }
}
