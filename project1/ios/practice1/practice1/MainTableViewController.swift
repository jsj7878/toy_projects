//
//  MainTableViewController.swift
//  practice1
//
//  Created by APPLE on 2022/09/30.
//  Copyright © 2022 sejin. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    var roomlist : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "http://www.example.com") else {return}
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "get"
        
        
        let dataTask = URLSession(configuration: .default).dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let jsonToArray = try? JSONSerialization.jsonObject(with: data, options: []) else {
                print("json to Any Error")
                return
            }
            print(jsonToArray)
        }
        dataTask.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = "1"
        // Configure the cell...

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: "http://www.example.com") else {return}
        
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "post"
       
        
//        let dataTask = URLSession(configuration: .default).uploadTask(with: request, from: ) {
//            (data: Data?, response: URLResponse?, error: Error?) in
//            guard error == nil else {
//                print("Error occur: \(String(describing: error))")
//                return
//            }
//            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                return
//            }
//            guard let jsonToArray = try? JSONSerialization.jsonObject(with: data, options: []) else {
//                print("json to Any Error")
//                return
//            }
//            print(jsonToArray)
//       }
//       dataTask.resume()
    }

}
