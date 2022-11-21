//
//  MainTableViewController.swift
//  practice1
//
//  Created by APPLE on 2022/09/30.
//  Copyright © 2022 sejin. All rights reserved.
//

import UIKit
import Foundation



class MainTableViewController: UITableViewController {
    var roomlist : [String] = []
    
    private lazy var roomTable: UITableView = {
        let tableView = UITableView()
        
        
        return tableView
    }()
    
    private func setupAutoLayout() {
        
        roomTable.translatesAutoresizingMaskIntoConstraints = false
        roomTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        roomTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        roomTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        roomTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(roomTable)
        guard let url = URL(string: "http://192.168.42.215:5050") else {return}
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
        guard let url = URL(string: "http://192.168.42.215:5050") else {return}
        
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let comment = PostComment(user_name: "dong", tier: "gold", position: "trash3")
        guard let uploadData = try? JSONEncoder().encode(comment) else {return}
        let dataTask = URLSession(configuration: .default).uploadTask(with: request, from: uploadData) {
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

}
