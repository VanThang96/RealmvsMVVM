//
//  ViewController.swift
//  RealmvsMVVM
//
//  Created by win on 4/3/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var disposed = DisposeBag()
    var itemViewModel = ItemViewModel()
    @IBOutlet weak var tbShowData: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleSearchBar()
    }
    @IBAction func btnAddNewData(_ sender: Any) {
        let alertVC = UIAlertController(title: "Add new Field", message: "", preferredStyle: .alert)
        alertVC.addTextField(configurationHandler: nil)
        alertVC.addTextField(configurationHandler: nil)
        alertVC.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let txtCode = alertVC.textFields![0] as UITextField
            let txtDistrict = alertVC.textFields![1] as UITextField
            let txtProvince = alertVC.textFields![2] as UITextField
            
            
            let item = Item()
            item.code = txtCode.text!
            item.district = txtDistrict.text!
            item.province = txtProvince.text!
            
//            try! self.realm.write {
//                self.realm.add(item)
//            }
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(addAction)
        present(alertVC, animated: true, completion: nil)
    }
    func handleSearchBar(){
        self.searchBar.rx.text
            .orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .asObservable()
            .distinctUntilChanged()
            .bind(to: self.itemViewModel.searchInput)
            .disposed(by: disposed)
        
        self.itemViewModel.result.asObservable()
            .bind(to: self.tbShowData.rx.items(cellIdentifier: "cellId", cellType: TableViewCell.self))
            {(index,item,cell) in
                cell.item = item
            }.disposed(by: disposed)
    }
}
//    func setupTableView(){
//        self.tbShowData.delegate = self
//        self.tbShowData.dataSource = self
//    }
//extension ViewController : UITableViewDataSource , UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return showItem.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? TableViewCell
//        cell?.item = showItem[indexPath.item]
//        return cell!
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            let item = arrayItem[indexPath.row]
//            try! self.realm.write {
//                self.realm.delete(item)
//            }
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
//}
