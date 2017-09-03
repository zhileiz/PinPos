//
//  AddNewVC.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/2.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit
import Hue
import SwiftIcons
import RealmSwift
import Realm
import SnapKit
import TextFieldEffects

class AddNewVC: UIViewController {

    @IBOutlet weak var fieldsView: UIView!
    @IBOutlet weak var catsView: UICollectionView!
    @IBOutlet weak var addNewBtn: UIButton!
    
    var searchField = HoshiTextField()
    var nameField = HoshiTextField()
    var addrField = HoshiTextField()
    var lngField = HoshiTextField()
    var latField = HoshiTextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetUp()
        setUpViews()
        addTextFields()
    }


}

extension AddNewVC{
    
    func navigationSetUp(){
        self.title = "Add New Place"
        view.backgroundColor = UIColor(hex: "EAEAEA")
        let img = UIImage.init(icon: .fontAwesome(.undo), size: CGSize(width: 25, height:25), textColor: UIColor(hex: "1364A5"))
        self.navigationController?.navigationBar.backIndicatorImage = img
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = img
    }
    
    func setUpViews(){
        fieldsView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(60)
            make.right.equalTo(view).offset(-60)
            make.top.equalTo(view).offset(100)
            make.height.equalTo(260)
        }
        fieldsView.backgroundColor = UIColor.white
        fieldsView.layer.cornerRadius = 10;
        fieldsView.layer.masksToBounds = true;
        catsView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(60)
            make.right.equalTo(view).offset(-60)
            make.top.equalTo(fieldsView).offset(280)
            make.height.equalTo(120)
        }
        catsView.backgroundColor = UIColor.white
        catsView.layer.cornerRadius = 10;
        catsView.layer.masksToBounds = true;
        addNewBtn.contentEdgeInsets = UIEdgeInsets(top: 5,left: 10,bottom: 5,right: 10)
        addNewBtn.backgroundColor = UIColor(hex: "1364A5")
        addNewBtn.setTitleColor(UIColor.white, for: .normal)
        addNewBtn.layer.cornerRadius = 5
        addNewBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(100)
            make.right.equalTo(view).offset(-100)
            make.top.equalTo(catsView).offset(150)
            make.height.equalTo(40)
        }
        addNewBtn.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
    }
    
    func addTextFields(){
        let fieldsArray = [searchField, nameField, addrField, lngField, latField]
        let placeHolders = ["Search For Your Place", "Name", "Address", "Longitude", "Latitude"]
        let icon:[FontType] = [FontType.linearIcons(.magnifier),FontType.linearIcons(.home),FontType.linearIcons(.location),FontType.linearIcons(.arrowUpCircle),FontType.linearIcons(.arrowRightCircle)]
        for f in fieldsArray {
            let index = fieldsArray.index(of: f)!
            f.placeholderColor = .darkGray
            f.placeholder = placeHolders[index]
            f.borderActiveColor = UIColor(hex: "1364A5")
            f.borderInactiveColor = .darkGray
            fieldsView.addSubview(f)
            let img = UIImage.init(icon: icon[index], size: CGSize(width:18,height:18), textColor: .darkGray)
            let iconView = UIImageView(image: img)
            fieldsView.addSubview(iconView)
            iconView.snp.makeConstraints{(make) -> Void in
                make.left.equalTo(fieldsView).offset(15)
                make.top.equalTo(index*50+15)
                make.width.height.equalTo(25)
            }
            f.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(iconView).offset(30)
                make.right.equalTo(fieldsView).offset(-20)
                make.top.equalTo(fieldsView).offset(index*50)
                make.height.equalTo(40)
            }
        }
        
    }
    
}
