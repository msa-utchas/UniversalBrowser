//
//  HistoryVC.swift
//  
//
//  Created by BJIT on 7/11/23.
//

import UIKit

class HistoryVC: UIViewController {
    
    var allHistory = CoredataManager.shared.getAllHistory()
    
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
            historyTV.register(UINib(nibName: "HistoryTVCell", bundle: nil), forCellReuseIdentifier: "HistoryTVCell")
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


extension HistoryVC{
    @objc private func btnDoneAction(){
        
    }
    @objc private func btnClearDataAction(){
        
    }
    @objc private func btnEditAction(){
        
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
}
