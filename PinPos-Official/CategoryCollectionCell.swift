//
//  CategoryCollectionCell.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/3.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    func setUpView(cat:Category){
        let hex = cat.color
        categoryName.text = cat.name
        categoryName.textColor = UIColor(hex: hex)
        categoryName.textAlignment = .center
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(hex: hex).alpha(0.1)
        self.selectedBackgroundView = bgColorView
        if cat.name == "Food"{
            categoryImg.image = UIImage(icon: .ionicons(.fork), size: CGSize(width:25,height:25), textColor: UIColor(hex:hex))
        } else if cat.name == "Sight"{
            categoryImg.image = UIImage(icon: .ionicons(.eye), size: CGSize(width:25,height:25), textColor: UIColor(hex:hex))
        } else if cat.name == "Life"{
            categoryImg.image = UIImage(icon: .ionicons(.filmMaker), size: CGSize(width:25,height:25), textColor: UIColor(hex:hex))
        } else {
            categoryImg.image = UIImage(icon: .ionicons(.pin), size: CGSize(width:25,height:25), textColor: UIColor(hex:hex))
        }
        categoryImg.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(20)
            make.width.height.equalTo(50)
        }
        categoryName.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(self.contentView).offset(-20)
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }

    }
}
