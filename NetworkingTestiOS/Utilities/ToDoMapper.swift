//
//  ToDoMapper.swift
//  NetworkingTestiOS
//
//  Created by Harry Summers on 7/8/17.
//  Copyright © 2017 harrysummers. All rights reserved.
//

import Foundation

class ToDoMapper {
    
    static func processTodosJson(_ responseData: Data, onComplete:@escaping(_ result: [ToDo]) -> Void) {
        var todos = [ToDo]()
        
        do {
            // Swift 3
            // guard let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) else { return }
            // let todo = ToDo(json: json) // make a ToDo constructor that takes in a stirng to any dictionary if you want to use this.
            
            // Swift 4
            todos = try JSONDecoder().decode([ToDo].self, from: responseData)
        } catch let jsonErr {
            print("Error serializing todo json: ",jsonErr)
        }
        
        onComplete(todos)
    }
    
    static func mapToBody(_ todo: ToDo) -> String? {
        let body = "body=\(String(describing: todo.body!))&title=\(String(describing: todo.title!))&isCompleted=\(String(describing: todo.isCompleted!))"
        return body
    }
}
