//
//  ChoiceView.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/2.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit
import SwiftIcons
import SnapKit
import Hue

class ChoiceView: UIView {
    
    var choiceBtn = UIButton(type: .custom)
    var typeLabel = UILabel(frame: CGRect(x: 30, y: 5, width: 50, height: 20))
    let size = CGSize(width: 30, height: 30)
    var counter = 0
    var catTable: UITableView?

    func setUpText(title:String){
        typeLabel.text = title
        typeLabel.textColor = UIColor(hex: "1364A5")
        typeLabel.textAlignment = .center
        typeLabel.font = UIFont(name: "Avenir", size: 20)
        self.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(self.frame.width - 80)
            make.centerY.equalTo(self)
            make.left.equalTo(choiceBtn).offset(10)
        }
    }
    
    func setUpImg(){
        let img = UIImage.init(icon: .fontAwesome(.chevronCircleDown), size: size, textColor: UIColor(hex: "1364A5"))
        choiceBtn.setImage(img, for: .normal)
        choiceBtn.addTarget(self, action: #selector(self.btnAction), for: .touchUpInside)
        self.addSubview(choiceBtn)
        choiceBtn.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(30)
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
    }
    
    func btnAction(_ sender: UIButton){
        let img = UIImage.init(icon: .fontAwesome(.chevronCircleDown), size: size, textColor: UIColor(hex: "1364A5"))
        let img2 = UIImage.init(icon: .fontAwesome(.chevronCircleUp), size: size, textColor: UIColor(hex: "1364A5"))
        if counter % 2 == 0 {
            self.choiceBtn.setImage(img2, for: .normal)
            catTable?.isHidden = false
        } else {
            self.choiceBtn.setImage(img, for: .normal)
            catTable?.isHidden = true
        }
        counter += 1
    }
    
    func setUp(){
        setUpImg()
        setUpText(title: "Any(10)")
    }


}
