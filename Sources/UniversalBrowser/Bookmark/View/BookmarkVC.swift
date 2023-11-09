//
//  BookmarkVC.swift
//  
//
//  Created by BJIT on 7/11/23.
//

import UIKit

class BookmarkVC: UIViewController {
    
    var allBookmark = CoredataManager.shared.getAllBookmarkByDateSorted()
    
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
            bookmarkTV.register(UINib(nibName: "BookmarkTVCell", bundle: Bundle.module), forCellReuseIdentifier: "BookmarkTVCell")
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


extension BookmarkVC{
    @objc private func btnDoneAction(){
        self.dismiss(animated: true)
    }
    @objc private func btnClearDataAction(){
        let myalert = UIAlertController(title: "Delete entire Bookmark?", message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ (action) in
            CoredataManager.shared.deleteAllBookmark()
            self.allBookmark = CoredataManager.shared.getAllBookmark()
            self.bookmarkTV.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        myalert.addAction(deleteAction)
        myalert.addAction(cancelAction)
        self.present(myalert,animated: true)
    }
    @objc private func btnEditAction(){
        if bookmarkTV.isEditing {
            bookmarkTV.isEditing = false
            btnEdit.setTitle("Edit", for: .normal)
        }
        else{
            bookmarkTV.isEditing = true
            btnEdit.setTitle("Done", for: .normal)
        }
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            CoredataManager.shared.deleteBookmark(bookmark: allBookmark[indexPath.row])
            allBookmark.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
