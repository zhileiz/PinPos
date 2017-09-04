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
    
    let realm = try! Realm()
    var categories = [Category]()
    var selectedCategory = Category()
    var anyCategory = Category()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateRealm()
        navigationSetUp()
        setUpViews()
        addTextFields()
        addNewBtn.addTarget(self, action: #selector(addNewPlace(_:)), for: .touchUpInside)
        catsView.delegate = self
        catsView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.barTintColor = UIColor(hex: "1364A5")
    }
    
    func populateRealm(){
        let cats = realm.objects(Category.self)
        anyCategory = cats.first!
        for cat in cats{
            print("from addNew Page:\(cat.name)")
            self.categories.append(cat)
        }
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
            f.delegate = self
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
    
    func addNewPlace(_ sender: UIButton) {
        guard let name = nameField.text else{
            showAlertForField(fieldname: "name")
            return
        }
        guard let addr = addrField.text else{
            showAlertForField(fieldname: "address")
            return
        }
        guard let lat = Double(latField.text ?? "lat") else{
            showAlertForField(fieldname: "latitude")
            return
        }
        guard let lng = Double(lngField.text ?? "lng") else{
            showAlertForField(fieldname: "longitude")
            return
        }
        let categories = realm.objects(Category.self)
        if categories.count == 0 {
            print ("!!! No Categories Yet !!!")
            showAlertForField(fieldname: "!!!CATEGORY!!!")
            return
        } else if selectedCategory.name == ""{
            showAlertForField(fieldname: "category")
            return
        }else {
            var place = Place()
            let category = selectedCategory
            print("Prepare to add to category: \(category.name)")
            place.update(name: name, addr: addr, lng: lng, lat: lat, cat: category)
            try! realm.write {
                realm.add(place)
                category.places.append(place)
                if (category.name != "Any"){
                    anyCategory.places.append(place)
                }
                print("received place \(place.name), at \(place.address), with lat:\(String(place.latitude)), and lng: \(String(place.longitude))")
            }
        }
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?[0]
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlertForField(fieldname:String){
        let alertController = UIAlertController(title: "Error", message: "Please Enter Field for \(fieldname)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Got It", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

extension AddNewVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension AddNewVC:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cat = categories[indexPath.row]
        if let cell = catsView.dequeueReusableCell(withReuseIdentifier: "itemId", for: indexPath) as? CategoryCollectionCell{
            cell.setUpView(cat: cat)
            return cell
        } else {
            print("could not draw item")
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 80.0, height: 120.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
        print("selected: \(selectedCategory.name)")
    }
}
