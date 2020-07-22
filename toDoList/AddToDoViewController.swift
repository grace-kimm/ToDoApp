//
//  AddToDoViewController.swift
//  toDoList
//
//  Created by kakao on 2020/07/21.
//  Copyright © 2020 ddaeng. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    @IBOutlet weak var toDoContents: UITextView!
    @IBOutlet weak var toDoTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        toDoContents.layer.borderColor = UIColor.gray.cgColor
        toDoContents.layer.borderWidth = 0.3
        toDoContents.layer.cornerRadius = 2.0
        toDoContents.clipsToBounds = true
    }
    
    @IBAction func editToDo(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addListItemAction(_ sender: Any) {
        let title = toDoTitle.text!
        let content = toDoContents.text ?? ""
        
        // 1. 'Done' 클릭 시 list에 데이터 append
        let item: ToDoList = ToDoList(title: title, content: content)
        
        print("Add List title: \(item.title)")
        list.append(item)
        
        // 2. list 화면으로 돌아가기
            self.navigationController?.popViewController(animated:true)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
