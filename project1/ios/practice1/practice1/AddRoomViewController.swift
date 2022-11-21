//
//  AddRoomViewController.swift
//  practice1
//
//  Created by APPLE on 2022/10/07.
//  Copyright © 2022 sejin. All rights reserved.
//

import UIKit
import DropDown

struct newRoom : Codable{
    let master_name = userName
    let room_name : String
    let tier_min : String
    let tier_max : String
    let people_max : Int
    let description : String

}


class AddRoomViewController: UIViewController {
    
    var newRoomName : String = ""
    var newRoomMinTier : String = " 최소 티어를 선택해주세요"
    var newRoomMaxTier : String = " 최대 티어를 선택해주세요"
    var newRoomPeopleMax : Int = 5
    var newRoomDescription : String = ""
    let minTierDropDown = DropDown()
    let maxTierDropDown = DropDown()
    
    
    private lazy var roomInfoStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [roomNameTextField, minTierDropDownButton,maxTierDropDownButton, roomDescriptionTextField])
        view.alignment = .leading
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.spacing = 15
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins.top = 15
        view.layoutMargins.bottom = 15
        return view
    }()
    
    
    private lazy var roomNameTextField : UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 8
        tf.placeholder = " 파티 제목을 입력하세요"
        tf.backgroundColor = .white
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    private var minTierDropDownButton: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.layer.cornerRadius = 8
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(minTierDropDownButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private var maxTierDropDownButton: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btn.layer.cornerRadius = 8
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(maxTierDropDownButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var roomDescriptionTextField : UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 8
        tf.placeholder = " 주소를 복사하세요"
        tf.backgroundColor = .white
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    private let roomAddButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.setTitleColor(#colorLiteral(red: 0.7167869606, green: 0.7167869606, blue: 0.7167869606, alpha: 1), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    func setMinTierDropDown(){
        let tierList = ["bronze 5", "silver 4","gold 3","gold 1","challenger"]
        minTierDropDown.dataSource = tierList
        minTierDropDown.anchorView = minTierDropDownButton
        minTierDropDown.dismissMode = .automatic
        minTierDropDown.bottomOffset = CGPoint(x:0, y:(minTierDropDown.anchorView?.plainView.bounds.height)!)
        minTierDropDown.selectionAction = { [weak self] (index, item)in
            self?.newRoomMinTier = item
            self?.minTierDropDownButton.setTitle(item, for: .normal)
            self?.checkAllInfoCreated()
        }
    }
    
    func setMaxTierDropDown(){
        let tierList = ["bronze 5", "silver 4","gold 3","gold 1","challenger"]
        maxTierDropDown.dataSource = tierList
        maxTierDropDown.anchorView = maxTierDropDownButton
        maxTierDropDown.dismissMode = .automatic
        maxTierDropDown.bottomOffset = CGPoint(x:0, y:(maxTierDropDown.anchorView?.plainView.bounds.height)!)
        maxTierDropDown.selectionAction = { [weak self] (index, item)in
            self?.newRoomMaxTier = item
            self?.maxTierDropDownButton.setTitle(item, for: .normal)
            self?.checkAllInfoCreated()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(roomInfoStackView)
        view.addSubview(roomAddButton)
        minTierDropDownButton.setTitle(newRoomMinTier, for: .normal)
        maxTierDropDownButton.setTitle(newRoomMaxTier, for: .normal)
        setupAutoLayout()
        setDropDown()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    func setupAutoLayout(){
        
        roomInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        roomInfoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        roomInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        roomInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        roomInfoStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        roomInfoStackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        roomNameTextField.translatesAutoresizingMaskIntoConstraints = false
        roomNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        roomNameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        minTierDropDownButton.translatesAutoresizingMaskIntoConstraints = false
        minTierDropDownButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        minTierDropDownButton.widthAnchor.constraint(equalToConstant: 200).isActive = true

        maxTierDropDownButton.translatesAutoresizingMaskIntoConstraints = false
        maxTierDropDownButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        maxTierDropDownButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        roomDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        roomDescriptionTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        roomDescriptionTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        roomAddButton.translatesAutoresizingMaskIntoConstraints = false
        roomAddButton.topAnchor.constraint(equalTo: roomInfoStackView.bottomAnchor, constant: 50).isActive = true
        roomAddButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170).isActive = true
        roomAddButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -170).isActive = true
        roomAddButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
    }

    func sendRoomToServer(){
        guard let url = URL(string: "http://192.168.43.119:3000/room") else {return}
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let nR = newRoom(room_name: newRoomName, tier_min: newRoomMinTier, tier_max: newRoomMaxTier, people_max: 5, description: newRoomDescription)
         guard let uploadData = try? JSONEncoder().encode(nR) else {return}
         let dataTask = URLSession(configuration: .default).uploadTask(with: request, from: uploadData) {
             (data: Data?, response: URLResponse?, error: Error?) in
             guard error == nil else {
                 print("Error occur: \(String(describing: error))")
                 return
             }
        }
        dataTask.resume()
    }
    
    func setDropDown(){
        DropDown.appearance().textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        DropDown.appearance().backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        DropDown.appearance().selectionBackgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        DropDown.appearance().setupCornerRadius(8)
    }
    
    @objc func minTierDropDownButtonTapped(){
        setDropDown()
        setMinTierDropDown()
        minTierDropDown.show()
    }
    
    @objc func maxTierDropDownButtonTapped(){
        setDropDown()
        setMaxTierDropDown()
        maxTierDropDown.show()
    }
    
    @objc func buttonTapped(){
        newRoomName = roomNameTextField.text ?? ""
        newRoomMaxTier = maxTierDropDownButton.titleLabel!.text!
        newRoomMinTier = minTierDropDownButton.titleLabel!.text!
        newRoomDescription = roomDescriptionTextField.text ?? ""
        sendRoomToServer()
        let nextView = RoomListViewController()
        nextView.modalPresentationStyle = .fullScreen
        self.present(nextView, animated: true, completion: nil)
    }
    
    func checkAllInfoCreated(){
        if  let name = roomNameTextField.text, !name.isEmpty,
            let minTier = minTierDropDownButton.titleLabel?.text, !minTier.isEmpty,
            let maxTier = maxTierDropDownButton.titleLabel?.text, !maxTier.isEmpty,
            let description = roomDescriptionTextField.text, !description.isEmpty
        {
            if minTier != " 최소 티어를 선택해주세요" && maxTier != " 최대 티어를 선택해주세요"{
                roomAddButton.backgroundColor = .clear
                roomAddButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                roomAddButton.isEnabled = true
                newRoomName = name
                newRoomMinTier = minTier
                newRoomMaxTier = maxTier
                newRoomDescription = description
            }
        }
        else {
            return
        }
    }

}
extension AddRoomViewController: UITextFieldDelegate {
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        checkAllInfoCreated()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

