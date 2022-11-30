//
//  RoomListViewController.swift
//  practice1
//
//  Created by APPLE on 2022/10/18.
//  Copyright © 2022 sejin. All rights reserved.
//

import UIKit

struct userInfo : Codable{
    var room_name : String
    var master_name : String
    var tier_min : String
    var tier_max : String
    var people_now : Int
    var people_max : Int
    var user_name : String
    var tier : String
    var position : String
    
}

struct checkUser : Codable{
    let user_name : String
    let room_name : String
    
}

struct accecptRoomInfo : Codable{
    let error : String
    let link : String
}

final class RoomListViewController: UIViewController{

    var userlist : [userInfo] = []
    var roomlist : [String] = []
    
    private lazy var upperImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "mainviewBackgroundImage-1")
        imageView.addSubview(upperImageViewLabel)
        return imageView
    }()
    
    private let upperImageViewLabel : UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "파티 리스트\n포지션이 맞는 파티원을 찾아 파티를 맺을 수 있습니다")
        attributedString.addAttributes([.font: UIFont.systemFont(ofSize: 20, weight: .bold)], range: NSRange(location: 0, length: 6))
        attributedString.addAttributes([.font: UIFont.systemFont(ofSize: 13, weight: .light)], range: NSRange(location: 6, length: attributedString.length - 6))
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()

    
    private var roomListTableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = CGFloat(1)
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return tableView
    }()
    
    
    private lazy var roomAddFloatingButton : UIButton = {
        let ft = UIButton()
        ft.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        ft.setTitle("+", for: .normal)
        ft.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        ft.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        ft.layer.cornerRadius = 25
        ft.clipsToBounds = true
        ft.addTarget(self, action: #selector(roomAddButtonTapped), for: .allTouchEvents)
        return ft
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getRoomData()
        view.addSubview(upperImageView)
        view.addSubview(roomListTableView)
        view.addSubview(roomAddFloatingButton)
        roomListTableView.delegate = self
        roomListTableView.dataSource = self
        setAutoLayout()
        roomListTableView.register(UserTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        roomListTableView.register(UserTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: UserTableViewHeaderFooterView.headerViewId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getRoomData()
    }
    
    func setAutoLayout(){
        upperImageView.translatesAutoresizingMaskIntoConstraints = false
        upperImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        upperImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        upperImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        upperImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        upperImageViewLabel.translatesAutoresizingMaskIntoConstraints = false
        upperImageViewLabel.centerXAnchor.constraint(equalTo: upperImageView.centerXAnchor).isActive = true
        upperImageViewLabel.centerYAnchor.constraint(equalTo: upperImageView.centerYAnchor).isActive = true
        
        
        roomListTableView.translatesAutoresizingMaskIntoConstraints = false
        roomListTableView.topAnchor.constraint(equalTo: upperImageView.bottomAnchor).isActive = true
        roomListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        roomListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        roomListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        roomAddFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        roomAddFloatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        roomAddFloatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        roomAddFloatingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        roomAddFloatingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    
    func getRoomData(){
        guard let url = URL(string: "http://192.168.43.119:3000/") else {return}
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "get"
        let dataTask = URLSession(configuration: .default).dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
                let decoder = JSONDecoder()
                if let json = try? decoder.decode([userInfo].self, from: data){
                    json.forEach{
                        self.userlist.append($0)
                    }
                }
                self.userlist.forEach{
                    self.roomlist.append($0.room_name)
                }
                var rl = Set<String>()
                self.roomlist = self.roomlist.filter{rl.insert($0).inserted}
                self.roomListTableView.reloadData()
            }
        }
        dataTask.resume()
    }
    
//    func getRoomData(){
//        userlist.append(userInfo(room_name: "자랭하실분 구합니다", master_name: "망치장인", tier_min: "bronze 5", tier_max: "gold 2", people_now: 3, people_max: 5, user_name: "망치장인", tier: "bronze 5", position: "buttom"))
//        userlist.append(userInfo(room_name: "자랭하실분 구합니다", master_name: "망치장인", tier_min: "bronze 5", tier_max: "gold 2", people_now: 3, people_max: 5, user_name: "이속잔나", tier: "silver 1", position: "support"))
//        userlist.append(userInfo(room_name: "자랭하실분 구합니다", master_name: "망치장인", tier_min: "bronze 5", tier_max: "gold 2", people_now: 3, people_max: 5, user_name: "삐오빠샤", tier: "silver 2", position: "mid"))
//        userlist.append(userInfo(room_name: "롤나나", master_name: "무무장인이정재", tier_min: "bronze 2", tier_max: "silver 3", people_now: 1, people_max: 5, user_name: "무무장인이정재", tier: "bronze 2", position: "jungle"))
//
//        userlist.forEach{
//            roomlist.append($0.room_name)
//        }
//        var rl = Set<String>()
//        roomlist = roomlist.filter{rl.insert($0).inserted}
//    }
    
    @objc func roomAddButtonTapped(){
        let nextView = AddRoomViewController()
        nextView.modalPresentationStyle = .fullScreen
        self.present(nextView, animated: true, completion: nil)
    }
    
    func checkRoomAccept(user_Name: String, room_Name: String){
        guard let url = URL(string: "http://192.168.43.119:3000") else {return}
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postCheckUser =  checkUser(user_name: user_Name, room_name: room_Name)
        guard let uploadData = try? JSONEncoder().encode(postCheckUser) else {return}
        let dataTask = URLSession(configuration: .default).uploadTask(with: request, from: uploadData) {
            (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
                let getRoomAccept = try! JSONDecoder().decode(accecptRoomInfo.self, from: data)
                self.showDialog(check: getRoomAccept)
                self.getRoomData()
            }
        }
        dataTask.resume()
        
    }
    
    func showDialog(check : accecptRoomInfo){
        let messageFromServer = check.error
        if messageFromServer == "E_OK"{
            let alert = UIAlertController(title: "확인되었습니다", message: check.link, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        else if messageFromServer == "E_Room_is_full"{
            let alert = UIAlertController(title: "방이 꽉 찼습니다", message: "이미 인원이 충족되었습니다. 다른 방을 선택해주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }
        else if messageFromServer == "E_Tier_doesn't_match"{
            let alert = UIAlertController(title: "조건에 맞지 않습니다", message: "조건 티어에 맞지 않습니다. 다른 방을 선택해주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "방에 이미 입장했습니다", message: "이미 다른 방에 입장하셨습니다. 링크를 확인해주세요. \(check.link)", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
extension RoomListViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard  let userTableViewHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserTableViewHeaderFooterView.headerViewId) as? UserTableViewHeaderFooterView else {
            return UIView()
        }
        
        userTableViewHeaderView.roomNameLabel.text = "\(roomlist[section])"
        let user = userlist.filter{$0.room_name == roomlist[section]}[0]
        userTableViewHeaderView.peopleNowMaxLabel.text = "\(user.people_now)/\(user.people_max)"
        userTableViewHeaderView.layer.addBorder([.top], color: .white, width: 2)
        
        return userTableViewHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let user = userlist.filter{$0.room_name == roomlist[section]}[0]
        return user.people_max
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = roomListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.backgroundColor = .black
        let nowUserlist = userlist.filter{$0.room_name == roomlist[indexPath.section]}
        
        if indexPath.row >= nowUserlist.count {
            cell.userNameLabel.text = "-"
            cell.userPositionLabel.text = "-"
            cell.userTierLabel.text = "-"
        }
        else{
            cell.userNameLabel.text = "\(nowUserlist[indexPath.row].user_name)"
            cell.userPositionLabel.text = "\(nowUserlist[indexPath.row].position)"
            cell.userTierLabel.text = "\(nowUserlist[indexPath.row].tier)"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return roomlist.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nowUserList = userlist.filter{$0.room_name == roomlist[indexPath.section]}
        checkRoomAccept(user_Name: userName, room_Name: nowUserList[indexPath.row].room_name)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }
    
}
