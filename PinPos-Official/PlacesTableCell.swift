//
//  PlacesTableCell.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/4.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit

class PlacesTableCell: UITableViewCell {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addrLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpView(place:Place){
        if place.categoryName == "Food"{
            categoryImg.image = UIImage(icon: .ionicons(.fork), size: CGSize(width:50,height:50), textColor: UIColor.black)
        } else if place.categoryName == "Sight"{
            categoryImg.image = UIImage(icon: .ionicons(.eye), size: CGSize(width:50,height:50), textColor: UIColor.black)
        } else if place.categoryName == "Life"{
            categoryImg.image = UIImage(icon: .ionicons(.filmMaker), size: CGSize(width:50,height:50), textColor: UIColor.black)
        } else {
            categoryImg.image = UIImage(icon: .ionicons(.pin), size: CGSize(width:50,height:50), textColor: UIColor.black)
        }
        categoryImg.snp.makeConstraints{(make) ->Void in
                make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(50)
            make.left.equalTo(self.contentView).offset(10)
        }
        nameLabel.text = place.name
        addrLabel.text = place.address
        nameLabel.snp.makeConstraints{(make) ->Void in
            make.left.equalTo(categoryImg).offset(70)
            make.top.equalTo(self.contentView).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        addrLabel.snp.makeConstraints{(make) ->Void in
            make.left.equalTo(categoryImg).offset(70)
            make.top.equalTo(nameLabel).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        let img = UIImage.init(icon: .fontAwesome(.edit), size: CGSize(width:35,height:35), textColor: UIColor.blue)
        editButton.setImage(img, for: .normal)
        editButton.snp.makeConstraints{(make) ->Void in
            make.right.equalTo(self.contentView).offset(-20)
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(50)
        }
        editButton.setTitle("", for: .normal)
    }
    

}
