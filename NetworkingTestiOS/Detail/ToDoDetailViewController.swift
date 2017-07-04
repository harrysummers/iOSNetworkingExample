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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        if (!isAddMode) {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        let url = "https://sheltered-ravine-36514.herokuapp.com/api/todos/\((todo?._id)!)"
        
        Alamofire.request(url , method: .delete, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print(response)
            self.navigationController?.popViewController(animated: true)
            
            
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        
        if (isAddMode) {
            let params: Parameters = [
                "title": titleTextField.text?.description as! String,
                "body" : bodyTextField.text?.description as! String,
                "isCompleted" : false
            ]
            
            Alamofire.request("https://sheltered-ravine-36514.herokuapp.com/api/todos", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                    print(response)
                self.dismiss(animated: true, completion: nil)
                
            }
        } else {
            let params: Parameters = [
                "title": titleTextField.text?.description as! String,
                "body" : bodyTextField.text?.description as! String,
                "isCompleted" : false
                
            ]
            
            let url = "https://sheltered-ravine-36514.herokuapp.com/api/todos/\((todo?._id)!)"
            
            Alamofire.request(url , method: .put, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                print(response)
                self.navigationController?.popViewController(animated: true)
                
                
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}
