//
//  ToDoWebService.swift
//  NetworkingTestiOS
//
//  Created by Harry Summers on 7/8/17.
//  Copyright © 2017 harrysummers. All rights reserved.
//

import UIKit

let TODO_BASE_URL = "https://sheltered-ravine-36514.herokuapp.com/api/todos"

class ToDoWebService {
    
    static func fetchTodos(onComplete:@escaping (_ result: [ToDo]) -> Void) {
        let url : URL = URL(string: TODO_BASE_URL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        AsyncWebService.shared.sendAsyncRequest(request: request) { (responseData) in
            ToDoMapper.processTodosJson(responseData) { (todos) in
                onComplete(todos)
            }
        }
        
        
    }
    
    static func postTodo(_ todo: ToDo, onComplete:@escaping () -> Void) {
        if let body = ToDoMapper.mapToBody(todo) {
            let url : URL = URL(string: TODO_BASE_URL)!
            
            var request = URLRequest(url: url)
            request.httpBody = body.data(using: .utf8)
            request.httpMethod = "POST"
            AsyncWebService.shared.sendAsyncRequest(request: request) { (responseData) in
                onComplete()
            }
        }
    }
    
    static func putTodo(_ todo: ToDo, onComplete:@escaping () -> Void) {
        if let body = ToDoMapper.mapToBody(todo) {
            let urlString = TODO_BASE_URL + "/" + todo._id!
            
            let url : URL = URL(string: urlString)!
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = body.data(using: .utf8)
            
            AsyncWebService.shared.sendAsyncRequest(request: request) { (responseData) in
                onComplete()
            }
        }
    }
    
    static func deleteTodo(_ todo: ToDo, onComplete:@escaping () -> Void) {
        let urlString = TODO_BASE_URL + "/" + todo._id!
        let url : URL = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        
        AsyncWebService.shared.sendAsyncRequest(request: request) { (responseData) in
            onComplete()
        }
        
    }
}
