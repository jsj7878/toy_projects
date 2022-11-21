////
////  MainViewController.swift
////  practice1
////
////  Created by APPLE on 2022/10/05.
////  Copyright © 2022 sejin. All rights reserved.
////
//
//import UIKit
//
//struct rooms : Codable {
//    var newRooms : [room]
//}
//
//struct room : Codable{
//    var name : String
//    var master_id : Int
//    var tier_min : String
//    var tier_max : String
//    var people_max : Int
//}
//
//class MainViewController: UIViewController{
//    var roomlist : [room] = []
//
//    private lazy var roomTable: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .clear
//        return tableView
//    }()
//
//    private let roomAddButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
//        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
//        button.setTitle("+", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        button.isEnabled = true
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private func setupAutoLayout() {
//
//        roomTable.translatesAutoresizingMaskIntoConstraints = false
//        roomTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
//        roomTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -100).isActive = true
//        roomTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
//        roomTable.heightAnchor.constraint(equalToConstant: 100).isActive = true
//      //  roomTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//
//        roomAddButton.translatesAutoresizingMaskIntoConstraints = false
//        roomAddButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        roomAddButton.topAnchor.constraint(equalTo: roomTable.bottomAnchor, constant: 200).isActive = true
//        roomAddButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 190).isActive = true
//        roomAddButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -190).isActive = true
//        roomAddButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
//
//    }
//
//    override func viewDidLoad() {
//        getRoomData()
//        super.viewDidLoad()
//        view.addSubview(roomTable)
//        view.addSubview(roomAddButton)
//        view.backgroundColor = .black
//        roomTable.dataSource = self
//        roomTable.delegate = self
//        print("mainView")
//        roomTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        setupAutoLayout()
//    }
//
//    func getRoomData(){
//        guard let url = URL(string: "http://192.168.30.1:3000/") else {return}
//        var request : URLRequest = URLRequest(url: url)
//        request.httpMethod = "get"
//        let dataTask = URLSession(configuration: .default).dataTask(with: request) {
//            (data: Data?, response: URLResponse?, error: Error?) in
//            guard error == nil else {
//                print("Error occur: \(String(describing: error))")
//                return
//            }
//            DispatchQueue.main.async {
//                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                                return
//                            }
//                            let decoder = JSONDecoder()
//                            print(String(decoding: data, as: UTF8.self))
//                            if let json = try? decoder.decode(room.self, from: data){
//                //                for i in 0...json.newRooms.count{
//                //                    self.roomlist.append(json.newRooms[i])
//                //                }
//                                self.roomlist.append(json)
//                            }
//            }
//
//        }
//        dataTask.resume()
//    }
//
//    func checkRoomAccept(){
//        guard let url = URL(string: "http://192.168.30.1:3000") else {return}
//        var request : URLRequest = URLRequest(url: url)
//        request.httpMethod = "get"
//
//        let dataTask = URLSession(configuration: .default).dataTask(with: request) {
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
//        }
//        dataTask.resume()
//
//    }
//
//    @objc func buttonTapped(){
//        let nextView = AddRoomViewController()
//        nextView.modalPresentationStyle = .fullScreen
//        self.present(nextView, animated: true, completion: nil)
//    }
//}
//
//extension MainViewController : UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return roomlist.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = roomTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
//        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        cell.layer.borderWidth = 2
//        cell.backgroundColor = .black
//        cell.textLabel?.text = "\(roomlist[indexPath.row].master_id)의 \(roomlist[indexPath.row].name)"
//        cell.textLabel?.textColor = .white
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        checkRoomAccept()
//
//    }
//
//}
