//
//  AsyncWebService.swift
//  NetworkingTestiOS
//
//  Created by Harry Summers on 7/8/17.
//  Copyright © 2017 harrysummers. All rights reserved.
//

import Foundation


final class AsyncWebService {
    
    static let shared = AsyncWebService()
    
    func sendAsyncRequest(request: URLRequest, onComplete:@escaping (_ result: Data) -> Void) {
        var request = request
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            guard error == nil else {
                print("error on processing url request")
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            onComplete(responseData)
        }.resume()
    }
    
    
}
