//
//  HistoryVC.swift
//
//
//  Created by BJIT on 7/11/23.
//

import UIKit

class HistoryVC: UIViewController {
    
    var allHistory = CoredataManager.shared.getAllHistoryByDateSorted()
    
    @IBOutlet weak var btnDone: UIButton!{
        didSet{
            btnDone.addTarget(self, action: #selector(btnDoneAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnClearData: UIButton!{
        didSet{
            btnClearData.addTarget(self, action: #selector(btnClearDataAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnEdit: UIButton!{
        didSet{
            btnEdit.addTarget(self, action: #selector(btnEditAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var historyTV: UITableView!{
        didSet{
            historyTV.delegate = self
            historyTV.dataSource = self
            historyTV.backgroundColor = .clear
            historyTV.register(UINib(nibName: "HistoryTVCell", bundle: Bundle.module), forCellReuseIdentifier: "HistoryTVCell")
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


extension HistoryVC{
    @objc private func btnDoneAction(){
        self.dismiss(animated: true)
    }
    @objc private func btnClearDataAction(){
        let myalert = UIAlertController(title: "Delete entire History?", message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ (action) in
            CoredataManager.shared.deleteAllHistory()
            self.allHistory = CoredataManager.shared.getAllHistory()
            self.historyTV.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        myalert.addAction(deleteAction)
        myalert.addAction(cancelAction)
        self.present(myalert,animated: true)
        
    }
    @objc private func btnEditAction(){
        if historyTV.isEditing {
            historyTV.isEditing = false
            btnEdit.setTitle("Edit", for: .normal)
        }
        else{
            historyTV.isEditing = true
            btnEdit.setTitle("Done", for: .normal)
        }
    }
}


extension HistoryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTV.dequeueReusableCell(withIdentifier: "HistoryTVCell", for: indexPath) as! HistoryTVCell
        cell.configure(model: allHistory[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            CoredataManager.shared.deleteHistory(history: allHistory[indexPath.row])
            allHistory.remove(at: indexPath.row)

            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = allHistory[indexPath.row].url{
            let dict:[String:String] = ["url":url]
            NotificationCenter.default.post(name: .loadNewUrl, object: nil, userInfo: dict)
        }
        self.dismiss(animated: true)
    }
}
