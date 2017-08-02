//
//  NetworkManager.swift
//  2w6d1_foodTracker
//
//  Created by Seantastic31 on 01/08/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    //MARK: Post Request
    static func requestPost(path: String, with formData : [String], completion: @escaping ([String:Any]) -> Void)
    {
        var components = URLComponents(string: "https://cloud-tracker.herokuapp.com" + path)!
        components.queryItems = [URLQueryItem(name: "username" , value: formData[0]), URLQueryItem(name: "password", value: formData[1])]
        let request = NSMutableURLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("\(components.url!)")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200  else {
                print("an error occurred problem with statusCode")
                return
            }
            // check the error status
            guard error == nil else
            {
                print(#line, error!.localizedDescription)
                return
            }
            guard let data = data else
            {
                print("no data returned")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any] else {
                print("data returned is not json, or not valid")
                return
            }
            completion(json)
        }
        // do something with the json object
        task.resume()
    }
    
    
    //MARK: Post Request
    static func requestGet(path: String, with formData : [String], completion: @escaping ([String:Any]) -> Void)
    {
        var components = URLComponents(string: "https://cloud-tracker.herokuapp.com" + path)!
        components.queryItems = [URLQueryItem(name: "username" , value: formData[0]), URLQueryItem(name: "password", value: formData[1])]
        let request = NSMutableURLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("\(components.url!)")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200  else {
                print("an error occurred problem with statusCode")
                return
            }
            // check the error status
            guard error == nil else
            {
                print(#line, error!.localizedDescription)
                return
            }
            guard let data = data else
            {
                print("no data returned")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any] else {
                print("data returned is not json, or not valid")
                return
            }
            completion(json)
        }
        // do something with the json object
        task.resume()
    }
}
