//
//  DataCell.swift
//  FixedPosition
//
//  Created by 飞翔 on 2020/6/4.
//  Copyright © 2020 飞翔. All rights reserved.
//

import UIKit
import SnapKit

class DataCell: UITableViewCell {
    
    lazy var nameLabel:UILabel = {
        let label = createLabel(title: "", font: .systemFont(ofSize: 14))
        return label
    }()
    
    lazy var sexLabel:UILabel = {
        let sexLabel = createLabel(title: "", font: .systemFont(ofSize: 15))
        return sexLabel
    }()
    
    lazy var ageLabel:UILabel = {
        let ageLabel = createLabel(title: "", font: .systemFont(ofSize: 14))
        return ageLabel
    }()
    
    lazy var underLabel:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepare()
        layout()
    }
    
    func prepare ()  {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(sexLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(underLabel)
    }
    
    func layout()  {
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
        }
        
        sexLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp_rightMargin).offset(10)
        }
        
        ageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(10)
        }
        
        underLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    func update(name:String,age:String,sex:String){
        nameLabel.text = name
        ageLabel.text = age
        sexLabel.text = sex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DataCell{
    
    func createLabel(title:String,font:UIFont) -> UILabel {
        
        let label = UILabel.init()
        label.text = title
        label.font = font
        //默认居中
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }
}
