//
//  BookmarkVC.swift
//  
//
//  Created by BJIT on 7/11/23.
//

import UIKit

class BookmarkVC: UIViewController {
    
    var allBookmark = CoredataManager.shared.getAllBookmark()
    
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
    @IBOutlet weak var bookmarkTV: UITableView!{
        didSet{
            bookmarkTV.delegate = self
            bookmarkTV.dataSource = self
            bookmarkTV.backgroundColor = .clear
            bookmarkTV.register(UINib(nibName: "BookmarkTVCell", bundle: nil), forCellReuseIdentifier: "BookmarkTVCell")
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


extension BookmarkVC{
    @objc private func btnDoneAction(){
        
    }
    @objc private func btnClearDataAction(){
        
    }
    @objc private func btnEditAction(){
        
    }
}


extension BookmarkVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBookmark.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookmarkTV.dequeueReusableCell(withIdentifier: "BookmarkTVCell", for: indexPath) as! BookmarkTVCell
        cell.configure(model: allBookmark[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
