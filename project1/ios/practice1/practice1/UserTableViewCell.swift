//
//  UserTableViewCell.swift
//  practice1
//
//  Created by APPLE on 2022/10/19.
//  Copyright © 2022 sejin. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    public var userNameLabel : UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    public var userPositionLabel : UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    public var userTierLabel : UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userPositionLabel)
        contentView.addSubview(userTierLabel)
        setAutoLayout()
        
        
    }
    
    func setAutoLayout(){
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        userNameLabel.preferredMaxLayoutWidth = 150
        
        userPositionLabel.translatesAutoresizingMaskIntoConstraints = false
        userPositionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 170).isActive = true
        userPositionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        userTierLabel.translatesAutoresizingMaskIntoConstraints = false
        userTierLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        userTierLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
