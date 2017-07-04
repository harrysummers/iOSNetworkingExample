//
//  ViewController.swift
//  NetworkingTestiOS
//
//  Created by Harry Summers on 7/4/17.
//  Copyright © 2017 harrysummers. All rights reserved.
//

import UIKit
import Alamofire

class ToDoListViewController: UITableViewController {
    
    var todos = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a
        self.title = "ToDos"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todos = []
        Alamofire.request("https://sheltered-ravine-36514.herokuapp.com/api/todos").responseJSON { response in
            
            let resultArray = response.result.value as! NSArray
            
            for todoDict in resultArray {
                let jsonTodo = todoDict as! NSDictionary
                let version = jsonTodo.value(forKey: "__v") as! Int
                let id = jsonTodo.value(forKey: "_id") as! String
                let body = jsonTodo.value(forKey: "body") as! String
                let isCompleted = jsonTodo.value(forKey: "isCompleted") as! Bool
                let title = jsonTodo.value(forKey: "title") as! String
                
                let todo = ToDo(__v: version, _id: id, body: body, isCompleted: isCompleted, title: title)
                self.todos.append(todo)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "todoDetailNav") as! UINavigationController
        
        self.present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todos[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let title = tableView.viewWithTag(1) as! UILabel
        title.text = todo.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "todoDetail") as! ToDoDetailViewController
        vc.todo = todo
        vc.isAddMode = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

