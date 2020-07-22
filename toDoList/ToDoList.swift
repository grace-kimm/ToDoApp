//
//  ToDoList.swift
//  toDoList
//
//  Created by kakao on 2020/07/21.
//  Copyright © 2020 ddaeng. All rights reserved.
//  data model

import Foundation
struct ToDoList {
    var title: String = ""
    var content: String?
    var isComplete: Bool = false
    
    init(title:String, content:String?, isComplete:Bool = false) {
        self.title = title
        self.content = content
        self.isComplete = isComplete
    }
}
