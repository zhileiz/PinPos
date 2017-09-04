//
//  CategoryTableCell.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/3.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import SwiftIcons
import Hue
import SnapKit

class CategoryTableCell: UITableViewCell {

    @IBOutlet weak var catgoryImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    func setUpView(cat:Category){
        let num = cat.getPlaces().count
        let hex = cat.color
        nameLabel.text = "\(cat.name)(\(num))"
        nameLabel.textColor = UIColor(hex: hex)
        nameLabel.textAlignment = .center
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(hex: hex).alpha(0.1)
        self.selectedBackgroundView = bgColorView
        if cat.name == "food"{
            catgoryImg.image = UIImage(icon: .ionicons(.fork), size: CGSize(width:25,height:25), textColor: UIColor(hex:hex))
        } else if cat.name == "sight"{
            catgoryImg.image = UIImage(icon: .ionicons(.eye), size: CGSize(width:25,height:25), textColor: UIColor(hex:hex))
        } else{
            catgoryImg.image = UIImage(icon: .ionicons(.filmMaker), size: CGSize(width:25,height:25), textColor: UIColor(hex:hex))
        }
        catgoryImg.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(15)
            make.width.height.equalTo(35)
        }
        nameLabel.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(self.contentView)
            make.centerX.equalTo(self.contentView).offset(15)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
    }

}
