//
//  ViewController.swift
//  toDoList
//
//  Created by kakao on 2020/07/21.
//  Copyright © 2020 ddaeng. All rights reserved.
//

import UIKit
// 할일 저장 리스트 (전역변수)
var list = [ToDoList]()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var toDoTableView: UITableView!
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap))
    
    // doneButtonTap 시 수정모드 종료
    @objc
    func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = editButton
        toDoTableView.setEditing(false, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].content
        if list[indexPath.row].isComplete {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // 수정모드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        toDoTableView.reloadData()
    }
    
    // 리스트 선택 시 완료 된 일로 표시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 이미 체크 되어 있는 경우 return
        guard !list[indexPath.row].isComplete else {
            return
        }
        
        // 리스트 선택 시 완료된 할 일 표시 (checkmark)
        list[indexPath.row].isComplete = true
        
        let dialog = UIAlertController(title: "ToDo List", message: "완료 되었습니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        dialog.addAction(action)
        self.present(dialog, animated: true, completion: nil)
        
        // 리스트 데이터 갱신
        toDoTableView.reloadData()
    }
    
    // userDefault 저장
    func saveAllData() {
        let data = list.map {
            [
                "title" : $0.title,
                "content" : $0.content!,
                "isComplete" : $0.isComplete
            ]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items")
        userDefaults.synchronize() // 동기화
    }
    
    // userDefault data 불러오기
    func loadAllData() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {
            return
        }
        
        print(data.description)
        
        // list array에 저장하기
        print(type(of: data))
        list = data.map {
            let title = $0["title"] as? String
            let content = $0["content"] as? String
            let isComplete = $0["isComplete"] as? Bool
            
            return ToDoList(title: title!, content: content!, isComplete: isComplete!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        guard !list.isEmpty else {
            return
        }
        toDoTableView.setEditing(true, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        toDoTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.append(ToDoList(title: "test1", content: "testData"))
        list.append(ToDoList(title: "test2", content: "testData"))
        list.append(ToDoList(title: "test3", content: "testData"))
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        doneButton.style = .plain
        doneButton.target = self
    }


}

