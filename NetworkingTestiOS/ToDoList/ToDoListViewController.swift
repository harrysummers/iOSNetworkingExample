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
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a
        self.title = "ToDos"
    }
    
    func startSpinner() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.center = self.view.center
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startSpinner()
        ToDoWebService.fetchTodos {result in
            self.todos = result
            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating()
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

