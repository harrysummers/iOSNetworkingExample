//
//  ToDoDetailViewController.swift
//  NetworkingTestiOS
//
//  Created by Harry Summers on 7/4/17.
//  Copyright © 2017 harrysummers. All rights reserved.
//

import UIKit
import Alamofire

class ToDoDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    var todo: ToDo?
    var isAddMode = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTextField.delegate = self
        self.bodyTextField.delegate = self
        
        if (todo != nil) {
            titleTextField.text = self.todo!.title
        }
        if (todo != nil) {
            bodyTextField.text = self.todo!.body
        }
        
        if (isAddMode) {
            deleteButton.isHidden = true
        } else {
            deleteButton.isHidden = false
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        if (!isAddMode) {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        deleteTodo()
    }
    
    @IBAction func savePressed(_ sender: Any) {
        if (isAddMode) {
            addTodo()
        } else {
            editTodo()
        }
    }
    
    func deleteTodo() {
        ToDoWebService.deleteTodo(todo!) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func addTodo() {
        let todo = ToDo(__v: nil,
                        _id: nil,
                        body: (bodyTextField.text?.description),
                        isCompleted: false,
                        title: (titleTextField.text?.description))
        
        ToDoWebService.postTodo(todo) {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func editTodo() {
        self.todo?.body = bodyTextField.text?.description
        self.todo?.title = titleTextField.text?.description
        
        ToDoWebService.putTodo(todo!) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}
