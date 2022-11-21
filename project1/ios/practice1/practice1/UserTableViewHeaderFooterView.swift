//
//  UserTableViewHeaderFooterView.swift
//  practice1
//
//  Created by APPLE on 2022/10/19.
//  Copyright © 2022 sejin. All rights reserved.
//

import UIKit

final class UserTableViewHeaderFooterView: UITableViewHeaderFooterView {

    static let headerViewId = "UserTableViewHeaderView"
    
    public var roomNameLabel : UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    public var peopleNowMaxLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.layer.cornerRadius = 6
        label.layer.borderWidth = 2
        label.layer.masksToBounds = true
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(roomNameLabel)
        contentView.addSubview(peopleNowMaxLabel)
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.layer.addBorder([.top], color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), width: 5)
        setAutoLayout()
    }
    
    func setAutoLayout(){
        
        roomNameLabel.translatesAutoresizingMaskIntoConstraints = false
        roomNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        roomNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        peopleNowMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        peopleNowMaxLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        peopleNowMaxLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        peopleNowMaxLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        peopleNowMaxLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//view 원하는 부분만 테두리 넣어주기
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
